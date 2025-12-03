
def-env nvm [...args] {
  let-env NVM_DIR = ($env.HOME | path join ".nvm")
  bash -c $"source /usr/share/nvm/nvm.sh && nvm ($args | str join ' ')"
}
