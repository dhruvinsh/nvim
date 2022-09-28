local status_ok, neogit = pcall(require, "neogit")

if status_ok then
  neogit.setup()
end
