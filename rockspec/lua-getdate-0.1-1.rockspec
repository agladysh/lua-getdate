package = "lua-getdate"
version = "0.1-1"
source = {
   url = "git://github.com/agladysh/lua-getdate.git",
   branch = "v0.1"
}
description = {
   summary = "Bindings to getdate()",
   homepage = "http://github.com/agladysh/lua-getdate",
   license = "MIT/X11",
   maintainer = "Alexander Gladysh <agladysh@gmail.com>"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      getdate = {
         sources = {
            "src/lua-getdate.c"
         },
         incdirs = {
            "src/"
         }
      }
   }
}
