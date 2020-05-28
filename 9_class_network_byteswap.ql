import cpp

class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
        exists( MacroInvocation mi | mi.getMacroName()="ntohl" or mi.getMacroName()="ntohll" or mi.getMacroName()="ntohs" | mi.getExpr() = this)
    }
}

from NetworkByteSwap n
select n, "Network byte swap"