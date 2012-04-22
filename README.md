lua-getdate — bindings for strptime()
=====================================

Usage
-----

```lua
require('getdate')
local strptime = getdate.strptime

local date, err = strptime(
    'Tue, 21 Feb 2012 01:02:03 GMT+04',
    '%a, %d %b %H:%M:%S GMT%Z'
  )
assert(err == nil)
for k, v in pairs(date) do
  print(k, v)
end
assert(date.year == 2012)
assert(date.mon == 2)
```

Installation
------------

Using LuaRocks (http://luarocks.org):

* Install current stable release:

    sudo luarocks install lua-getdate

* Install current Git master head from GitHub:

    sudo luarocks install lua-getdate --from=rocks-cvs

* Install from current working copy

    cd lua-getdate/
    sudo luarocks make rockspec/lua-getdate-scm-1.rockspec

License
-------

See the copyright information in the file named `COPYRIGHT`.
