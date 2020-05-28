import cpp
from MacroInvocation mi
where mi.getMacroName() = "ntohs" or mi.getMacroName() = "ntohl" or mi.getMacroName() = "ntohll"
select mi.getExpr(), "macro expression"