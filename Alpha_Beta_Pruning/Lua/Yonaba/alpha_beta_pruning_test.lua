-- Tests for alpha_beta_pruning.lua
local ABP = require 'alpha_beta_pruning'

local total, pass = 0, 0

local function dec(str, len)
  return #str < len
     and str .. (('.'):rep(len-#str))
      or str:sub(1,len)
end

local function run(message, f)
  total = total + 1
  local ok, err = pcall(f)
  if ok then pass = pass + 1 end
  local status = ok and 'PASSED' or 'FAILED'
  print(('%02d. %68s: %s'):format(total, dec(message,68), status))
end

run('Testing ABP', function()
  local tree = require 'handlers.tree_handler'

  local t = tree()
  t:addNode('A',nil,0)
  t:addNode('B','A',0)
  t:addNode('C','A',0)
  t:addNode('D','A',0)

  t:addNode('E','B',4)
  t:addNode('F','B',12)
  t:addNode('G','B',7)

  t:addNode('H','C',10)
  t:addNode('I','C',5)
  t:addNode('J','C',6)

  t:addNode('K','D',1)
  t:addNode('L','D',2)
  t:addNode('M','D',3)

  local head = t:getNode('A')
  assert(ABP(head, t, 3) == 5)
end)

print(('-'):rep(80))
print(('Total : %02d: Pass: %02d - Failed : %02d - Success: %.2f %%')
  :format(total, pass, total-pass, (pass*100/total)))
