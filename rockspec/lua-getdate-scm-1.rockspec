package = "lua-getdate"
version = "scm-1"
source = {
   url = "git://github.com/agladysh/lua-getdate.git",
   branch = "master"
}
description = {
   summary = "Bindings for strptime()",
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
