--------------------------------------------------------------------------------
-- 0001-strptime.lua: tests for strptime binding
-- This file is a part of lua-getdate library
-- Copyright (c) lua-getdate authors (see file `COPYRIGHT` for the license)
--------------------------------------------------------------------------------

local make_suite = ...

--------------------------------------------------------------------------------

local getdate = require('getdate')
local strptime = getdate.strptime

local ensure,
      ensure_equals,
      ensure_error,
      ensure_fails_with_substring,
      ensure_strequals,
      ensure_tdeepequals
      = import 'lua-nucleo/ensure.lua'
      {
        'ensure',
        'ensure_equals',
        'ensure_error',
        'ensure_fails_with_substring',
        'ensure_strequals',
        'ensure_tdeepequals'
      }

--------------------------------------------------------------------------------

local test = make_suite('strptime')

-- assume local timezone is GMT+04
local GMT_OFFSET = 4

--------------------------------------------------------------------------------

test 'strptime-honors-local-timezone' (function()
  local ts = os.time()
  local str = os.date('%c %Z', ts)
  local tbl = os.date('*t', ts)
  ensure_equals(
      'os.time() likes strptime return',
      os.time(strptime(str, '%c %Z')),
      ts
    )
  ensure_tdeepequals(
      'os.date("*t") equivalent to strptime()',
      strptime(str, '%c %Z'),
      tbl
    )
end)

test 'strptime-honors-UTC' (function()
  local ts = os.time()
  local str = os.date('%c %Z', ts)
  ensure_equals(
      'os.time() likes strptime return',
      os.time(strptime(str, '%c %Z')),
      ts
    )
  -- tbl.hour in local TZ
  local tbl = os.date('!*t', ts + 3600 * GMT_OFFSET)
  --[[ N.B. the following fails at new day boundary
  local tbl = os.date('!*t', ts)
  tbl.hour = tbl.hour + GMT_OFFSET
  ]]--
  ensure_tdeepequals(
      'os.date("!*t") equivalent to strptime()',
      strptime(str, '%c %Z'),
      tbl
    )
end)

test 'strptime-parse-epoch-date' (function()
  local epoch = strptime('1329820391', '%s')
  ensure_tdeepequals(
      'strptime() parses epoch time',
      os.date('*t', 1329820391),
      epoch
    )
end)

test 'strptime-parse-epoch-date-in-local-timezone' (function()
  local epoch = strptime('1329820391', '%s')
  -- N.B. epoch time in local TZ
  epoch.hour = epoch.hour - GMT_OFFSET
  ensure_tdeepequals('strptime() reports local time',
      os.date('!*t', 1329820391),
      epoch
    )
end)

test 'strptime-parses-rfc6265-date' (function()
  ensure_tdeepequals(
      'os.date() equivalent to strptime()',
      os.date('!*t', 1329820391),
      strptime(
          'Tue, 21 Feb 2012 10:33:11 GMT',
          '%a, %d %b %Y %H:%M:%S GMT%Z'
        )
    )
end)

test 'strptime-format' (function()
  ensure_fails_with_substring(
      'strptime() should be given correct format',
      function()
        local date, err = strptime(
            'Tue, 21 Feb 2012 10:33:11 GMT+0400',
            '%a, %d %b %Y %H:%M:%S %z'
          )
        assert(date, 'strptime should be given correct format: ' .. err)
      end,
      'strptime should be given correct format: failed to parse date'
    )
end)

--------------------------------------------------------------------------------

assert(test:run())
