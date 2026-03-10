---
name: NestJS Module Structure
description: >
  Estructura estándar de módulos en NestJS con SQL, Entity, Type, DTO y Service.
  Trigger: Al crear un nuevo módulo en NestJS o al trabajar con la estructura de módulos.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Estructura de Archivos

```
module-name/
├── sql/
│   └── module-name.sql.ts          # Consultas SQL/enums
├── entities/
│   └── tb.module-name.entity.ts    # Clase con @Expose para mapeo
├── type/
│   ├── module-name.entity.ts       # Type equivalente a entity
│   └── module-name.types.ts        # Tipos para CRUD (IdType, PostType, PatchType)
├── dtos/
│   ├── create-module-name.dto.ts   # DTO para creación (swagger)
│   ├── update-module-name.dto.ts   # DTO para actualización
│   └── module-name-id.dto.ts      # DTO para eliminación
├── module-name.controller.ts
├── module-name.module.ts
└── module-name.service.ts
```

## Propósito de Cada Capa

### 1. SQL (Consultas)

Archivo con enumerador que contiene las consultas SQL. Los nombres de columnas están en español (como vienen de la base de datos).

```typescript
// sql/module-name.sql.ts
export enum ModuleNameSql {
  GetAll = `
    SELECT 
      idparammediorespuesta,
      mediorespuesta,
      descripcion
    FROM 
      tb_pqrs_parammediosrespuesta
    WHERE activo = 1  
    ORDER BY idparammediorespuesta
  `,
  // ... otras consultas
}
```

### 2. Entity (Clase con Decoradores)

Clase que mapea las columnas de la BD (español) a propiedades en inglés. Usa `@Expose` de `class-transformer`.

```typescript
// entities/tb.module-name.entity.ts
import { Expose } from 'class-transformer';

export class TbPqrsResponseMediumEntity {
  @Expose({ name: 'idparammediorespuesta' })
  paramResponseChannelId: string;

  @Expose({ name: 'mediorespuesta' })
  responseChannel: string;

  @Expose({ name: 'descripcion' })
  description: string;
}
```

### 3. Type (TypeScript Type)

Tipo equivalente a la entity pero sin decoradores. Se usa como tipo de retorno en el service.

```typescript
// type/module-name.entity.ts
export type TbPqrsResponseMediumEntityType = {
  paramResponseChannelId: string;
  responseChannel: string;
  description: string;
}
```

### 4. Types Adicionales

Tipos específicos para las operaciones CRUD.

```typescript
// type/module-name.types.ts
export type IdType = {
  paramResponseChannelId: string;
}

export type PostType = {
  responseChannel: string;
  description?: string;
}

export type PatchType = PostType & IdType;
```

### 5. DTO (Data Transfer Object)

Clase con decoradores de `class-validator` y `nestjs/swagger` para documentación y validación en el controller.

```typescript
// dtos/create-module-name.dto.ts
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsString, IsOptional } from "class-validator";

export class CreateParamResponseChannelDto {
  @ApiProperty({
    description: "Medio De Respuesta",
    example: "Respuesta Test",
    type: String,
    required: true,
  })
  @IsString()
  @IsNotEmpty()
  responseChannel: string;

  @ApiProperty({
    description: "Descripcion",
    example: "Description Test",
    type: String,
    required: false,
  })
  @IsOptional()
  @IsString()
  description?: string;
}
```

### 6. Service

Uso del `plpgsqlService` (o `plsqlService` para Oracle). El tipo genérico `<Type>` es para el retorno, y la entity se pasa para el mapeo.

```typescript
// module-name.service.ts
async getAll(): Promise<TbPqrsResponseMediumEntityType[]> {
  const result = await this.plpgsqlService.executeQuery<TbPqrsResponseMediumEntityType>(
    ModuleNameSql.GetAll,
    [],
    TbPqrsResponseMediumEntity,  // Entity para mapeo
  );
  return result;
}

async create(param: PostType): Promise<string> {
  const result = await this.plpgsqlService.executeQuery<{ id: number }>(
    ModuleNameSql.Create,
    [param.responseChannel, param.description],
  );
  return result[0]?.id;
}
```

## Flujo de Datos

```
SQL (español)
    ↓ @Expose()
Entity (clase con mapeo)
    ↓ tipado
Type (type sin decoradores)
    ↓ validación + swagger
DTO (clase con @ApiProperty, @IsString, etc.)
    ↓ controller
Service (usa Type para retornos, Entity para mapeo)
```

## Keywords

nestjs, module, entity, dto, type, sql, repository, service, controller, class-transformer, class-validator
