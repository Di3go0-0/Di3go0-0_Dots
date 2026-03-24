---
name: NestJS Module Structure
description: >
  Estructura estándar de módulos en NestJS con Oracle 11g, Entity, Type, DTO y Service.
  Trigger: Al crear un nuevo módulo en NestJS o al trabajar con la estructura de módulos.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "2.0"
---

## Estructura de Archivos

```
module-name/
├── sql/
│   └── module-name.sql.ts          # Consultas SQL/enums
├── entities/
│   └── tb.module-name.entity.ts    # Clase con @Expose para mapeo
├── types/
│   ├── module-name.type.ts         # Type equivalente a entity (sin decoradores)
│   └── module-name.types.ts        # Tipos para CRUD (IdType, PostType, PatchType)
├── dtos/
│   ├── create-module-name.dto.ts   # DTO para creación (swagger)
│   ├── update-module-name.dto.ts   # DTO para actualización
│   └── module-name-id.dto.ts       # DTO para obtención/eliminación
├── constants/
│   └── module-name.constants.ts    # Constantes API, mensajes y errores
├── module-name.controller.ts
├── module-name.module.ts
├── module-name.service.ts
└── module-name.service.spec.ts     # Tests unitarios
```

## Propósito de Cada Capa

### 1. SQL (Consultas Oracle)

Archivo enum con las consultas SQL. Los nombres de columnas están en MAYÚSCULAS (como vienen de Oracle).

**Regla importante:** Cuando se usa una función de encriptación, el alias `AS` debe llevar el mismo nombre de la columna que entra en la función:

```typescript
// sql/module-name.sql.ts
export enum ModuleNameSql {
  GetById = `
    SELECT
      SEGURIDAD.PKG_SEG_SEGURIDAD.ENCRIPTAR3(IDGRUPO) AS IDGRUPO,
      CUPOSMINIMOS
    FROM REGISTRO.TB_MAT_GRUPO
    WHERE IDGRUPO = :id
  `,
  // ... otras consultas (POST, PUT, DELETE)
}
```

### 2. Entity (Clase con Decoradores)

Clase que mapea las columnas de Oracle (MAYÚSCULAS) a propiedades en camelCase. Usa `@Expose` de `class-transformer`.

```typescript
// entities/tb.module-name.entity.ts
import { Expose } from 'class-transformer';

export class TbMatGroupEntity {
  @Expose({ name: 'IDGRUPO' })
  groupId: string;

  @Expose({ name: 'CUPOSMINIMOS' })
  minSeats: string;
}
```

### 3. Type (TypeScript Type)

Tipo equivalente a la entity pero **sin decoradores**. Refleja exactamente la estructura que retorna el service.

```typescript
// types/module-name.type.ts
export type ModuleNameType = {
  groupId: string;
  minSeats: string;
}
```

### 4. Types Adicionales (CRUD)

Tipos específicos para las operaciones CRUD. Se usan en el service según cantidad de parámetros:
- **1 parámetro simple**: NO se define un Type de entrada
- **1 o más parámetros**: SE define un Type de entrada

```typescript
// types/module-name.types.ts
export type IdType = {
  groupId: string;
}

export type PostType = {
  minSeats: string;
  // ... otros campos
}

export type PatchType = PostType & IdType;
```

### 5. DTO (Data Transfer Object)

Clase con decoradores de `class-validator` y `nestjs/swagger`. **Solo se usa en el controller**.

```typescript
// dtos/get-module-name.dto.ts
import { ApiProperty } from "@nestjs/swagger";
import { IsString, IsNotEmpty } from "class-validator";

export class GetModuleNameDto {
  @ApiProperty({
    description: "ID encriptado del grupo",
    example: "encrypted-id-123",
    type: String,
  })
  @IsString()
  @IsNotEmpty()
  groupId: string;
}
```

### 6. Constants

Enum con constantes de API, mensajes y errores. Se importa en controller y service para evitar strings quemados.

```typescript
// constants/module-name.constants.ts
export const MODULE_NAME_CONSTANTS = {
  API: {
    GET: 'Obtiene un grupo por ID',
    GET_ALL: 'Obtiene todos los grupos',
    CREATE: 'Crea un nuevo grupo',
    UPDATE: 'Actualiza un grupo existente',
    DELETE: 'Elimina un grupo',
  },
  MESSAGES: {
    GROUP_CREATED: 'Grupo creado exitosamente',
    GROUP_UPDATED: 'Grupo actualizado correctamente',
    GROUP_DELETED: 'Grupo eliminado correctamente',
  },
  ERRORS: {
    GROUP_NOT_FOUND: 'Grupo no encontrado',
    INVALID_GROUP_ID: 'ID de grupo inválido',
  },
  RESPONSES: {
    GROUP_DETAIL: 'Detalle del grupo',
    GROUPS_LIST: 'Lista de grupos',
  },
  PARAMS: {
    GROUP_ID: 'ID encriptado del grupo',
  },
};
```

### 7. Service

El service usa `plsqlService` (para Oracle). El Type genérico es para el retorno, y la Entity se pasa para el mapeo.

**Responsabilidades:**
- Defina el tipo de retorno (`Promise<Type>`)
- Use Entity para mapeo de datos
- Use logger para errores
- Capture excepciones y re-lance

```typescript
// module-name.service.ts
import { Injectable, Logger } from '@nestjs/common';
import { PlsqlService } from 'src/core/database/services';
import { ModuleNameSql } from './sql/module-name.sql';
import { TbMatGroupEntity } from './entities/tb.module-name.entity';
import { ModuleNameType } from './types/module-name.type';

@Injectable()
export class ModuleNameService {
  private readonly logger = new Logger(ModuleNameService.name);

  constructor(private readonly plsqlService: PlsqlService) {}

  /**
   * Obtiene un grupo específico por su ID encriptado.
   * @param groupId - ID encriptado del grupo
   * @returns Datos del grupo o null si no existe
   */
  async getById(groupId: string): Promise<ModuleNameType | null> {
    try {
      const result = await this.plsqlService.executeQuery<ModuleNameType>(
        ModuleNameSql.GetById,
        [groupId],
        TbMatGroupEntity, // Entity para mapeo
      );
      return result.length > 0 ? result[0] : null;
    } catch (error) {
      this.logger.error(error);
      throw error;
    }
  }

  // POST, PUT, DELETE: ver ejemplos en offers.service.ts
}
```

### 8. Tests Unitarios (Jest)

Los tests **solo se hacen para services**, nunca para controllers. Se mockean las dependencias.

```typescript
// module-name.service.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { ModuleNameService } from './module-name.service';
import { PlsqlService } from 'src/core/database/services';

describe('ModuleNameService', () => {
  let service: ModuleNameService;
  let plsqlService: jest.Mocked<PlsqlService>;

  beforeEach(async () => {
    plsqlService = {
      executeQuery: jest.fn(),
    } as any;

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ModuleNameService,
        { provide: PlsqlService, useValue: plsqlService },
      ],
    }).compile();

    service = module.get(ModuleNameService);
  });

  afterEach(() => jest.clearAllMocks());

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('getById', () => {
    it('should return group data when found', async () => {
      const mockData = [{ groupId: 'group-1', minSeats: '10' }];
      plsqlService.executeQuery.mockResolvedValue(mockData);

      const result = await service.getById('group-1');

      expect(plsqlService.executeQuery).toHaveBeenCalledWith(
        expect.any(String),
        ['group-1'],
        expect.any(Function),
      );
      expect(result).toEqual(mockData[0]);
    });

    it('should return null when group not found', async () => {
      plsqlService.executeQuery.mockResolvedValue([]);

      const result = await service.getById('nonexistent-id');

      expect(result).toBeNull();
    });

    it('should throw error on database failure', async () => {
      const error = new Error('Database error');
      plsqlService.executeQuery.mockRejectedValue(error);

      await expect(service.getById('group-1')).rejects.toThrow(error);
    });
  });
});
```

## Flujo de Datos

```
SQL (MAYÚSCULAS Oracle)
    ↓ @Expose({ name: 'COLUMNAORACLE' })
Entity (clase con mapeo a camelCase)
    ↓ tipado
Type (type sin decoradores - retorno del service)
    ↓ validación + swagger
DTO (clase con @ApiProperty, @IsString, etc. - entrada del controller)
    ↓ controller pasa al service
Service (usa Type para retornos, Entity para mapeo)
    ↓
Response (camelCase)
```

## Reglas Clave

### Mapeo de Columnas Encriptadas

Cuando se usa una función de encriptación, el alias debe ser igual al nombre de la columna:

✅ **Correcto:**
```sql
SELECT
  SEGURIDAD.PKG_SEG_SEGURIDAD.ENCRIPTAR3(IDGRUPO) AS IDGRUPO,
  SEGURIDAD.PKG_SEG_SEGURIDAD.ENCRIPTAR3(IDPERSONA) AS IDPERSONA
FROM TABLA
```

❌ **Incorrecto:**
```sql
SELECT
  SEGURIDAD.PKG_SEG_SEGURIDAD.ENCRIPTAR3(IDGRUPO) AS groupId,
  SEGURIDAD.PKG_SEG_SEGURIDAD.ENCRIPTAR3(IDPERSONA)
FROM TABLA
```

### Tipos en el Service

| Parámetros | Definen Type |
|-----------|--------------|
| Ninguno (GET all) | No (devuelve array vacío) |
| 1 parámetro simple (GET by ID) | No (se pasa directo) |
| 1 o más parámetros (POST, PUT) | Sí (PostType, PatchType) |
| 1 o más parámetros (DELETE) | No (solo el ID) |

### Responsabilidades por Capa

| Capa | Responsabilidad |
|------|-----------------|
| **SQL** | Nombre de columnas exactos de Oracle |
| **Entity** | Mapeo Oracle → camelCase con @Expose |
| **Type** | Estructura tipada de retorno del service |
| **DTO** | Validación y documentación Swagger del input |
| **Service** | Lógica de negocio y tipo de retorno Promise<Type> |
| **Controller** | NO define tipo de retorno (hereda del service) |
| **Test** | Solo para services, mockear dependencias |

## Keywords

nestjs, module, entity, type, dto, oracle, sql, plsql, service, controller, class-transformer, class-validator, jest, testing, oracledb
