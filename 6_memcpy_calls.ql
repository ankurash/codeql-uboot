
import cpp
from FunctionCall fc
where fc.getTarget().getName() = "memcpy"
select fc,"function call to memcpy"