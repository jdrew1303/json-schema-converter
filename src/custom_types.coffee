hour = '(0[0-9]|1[0-9]|2[0-3])'
min_or_sec = '(:[0-5][0-9])'
tz = ""

DATE_OR_DATETIME_REGEX = ///     #        req?
  ^ [0-9]{4}                     # year      Y
  ([-/.](0[1-9]|1[012])          # month     Y
  ([-/.](0[1-9]|[12][0-9]|3[01]) # day       Y
      # this is b/c json-schema  #           -
      # can't handle \s          #           -
      ([Tt#{' '}]                # sep       Y, if TZ
        ( #{hour}                # hour 00   N
          #{min_or_sec}?         # min :00   N
          #{min_or_sec}?         # sec :00   N
        )?                       #           -
        (                        #           -
          [zZ]                   # Zz        N
          | ( [-+]               # -/+       Y, if TZ
              #{hour}            # hour off  Y, if TZ
              #{min_or_sec}?     # min off   N
            )?
        )?
      )?
    )?
  )? $
///

module.exports =
  objectid:
    ref: "#/definitions/objectid"
    definition: objectid: { type: 'string', pattern: '^[0-9a-fA-F]{24}$' }
  date_or_datetime:
    ref: "#/definitions/date_or_datetime"
    definition: date_or_datetime: { type: 'string', pattern: DATE_OR_DATETIME_REGEX.toString()[1..-2] }
