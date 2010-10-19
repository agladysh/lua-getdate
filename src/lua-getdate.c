/*
* lua-inih.c: bindings for inih, simple .INI file parser
*/

#define LUAGETDATE_VERSION     "lua-getdate 0.1"
#define LUAGETDATE_COPYRIGHT   "Copyright (C) 2010, lua-getdate authors"
#define LUAGETDATE_DESCRIPTION "Bindings for getdate() function"

#if defined (__cplusplus)
extern "C" {
#endif

#include <lua.h>
#include <lauxlib.h>

#include <string.h> /* memset */
#include <time.h> /* strptime */

#if defined (__cplusplus)
}
#endif

/* From lua5.1.4 loslib.c */
static void setfield (lua_State *L, const char *key, int value) {
  lua_pushinteger(L, value);
  lua_setfield(L, -2, key);
}

/* From lua5.1.4 loslib.c */
static void setboolfield (lua_State *L, const char *key, int value) {
  if (value < 0)  /* undefined? */
    return;  /* does not set field */
  lua_pushboolean(L, value);
  lua_setfield(L, -2, key);
}

/*
* getdate.strptime(date : string, format : string) 
*   : time table in os.time() format / nil, error_message
*/
static int l_strptime(lua_State * L)
{
  const char * date = luaL_checkstring(L, 1);
  const char * format = luaL_checkstring(L, 2); 
  struct tm tm;

  memset(&tm, 0, sizeof(tm));
  
  if (!strptime(date, format, &tm))
  {
    lua_pushnil(L);
    lua_pushliteral(L, "failed to parse date");
    return 2;
  }
  
  /* From lua5.1.4 loslib.c */
  lua_createtable(L, 0, 9);  /* 9 = number of fields */
  setfield(L, "sec", tm.tm_sec);
  setfield(L, "min", tm.tm_min);
  setfield(L, "hour", tm.tm_hour);
  setfield(L, "day", tm.tm_mday);
  setfield(L, "month", tm.tm_mon + 1);
  setfield(L, "year", tm.tm_year + 1900);
  setfield(L, "wday", tm.tm_wday + 1);
  setfield(L, "yday", tm.tm_yday + 1);
  setboolfield(L, "isdst", tm.tm_isdst);

  return 1;
}

/* Lua module API */
static const struct luaL_reg R[] =
{
  { "strptime", l_strptime },
  { NULL, NULL }
};

#ifdef __cplusplus
extern "C" {
#endif

LUALIB_API int luaopen_getdate(lua_State * L)
{
  /*
  * Register module
  */
  luaL_register(L, "getdate", R);

  /*
  * Register module information
  */
  lua_pushliteral(L, LUAGETDATE_VERSION);
  lua_setfield(L, -2, "_VERSION");

  lua_pushliteral(L, LUAGETDATE_COPYRIGHT);
  lua_setfield(L, -2, "_COPYRIGHT");

  lua_pushliteral(L, LUAGETDATE_DESCRIPTION);
  lua_setfield(L, -2, "_DESCRIPTION");

  return 1;
}

#ifdef __cplusplus
}
#endif
