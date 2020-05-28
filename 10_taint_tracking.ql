import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
        exists( MacroInvocation mi | mi.getMacroName()="ntohl" or mi.getMacroName()="ntohll" or mi.getMacroName()="ntohs" | mi.getExpr() = this)
    }
}

class Config extends TaintTracking::Configuration {
    Config() { this = "NetworkToMemFuncLength" }

    override predicate isSource(DataFlow2::Node source) {
        source.asExpr() instanceof NetworkByteSwap
    }
    override predicate isSink(DataFlow::Node sink) {
        exists (FunctionCall fc |
        fc.getTarget().getName() = "memcpy" and sink.asExpr() = fc.getArgument(2)
        )
    }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"