#script (python)
from clingo import Number, String, SymbolType

class Context:
    def helper(self, x):
        print("helper", x)
        if x.type == SymbolType.Number:
            return Number(x.number * 2)
        else:
            return Number(0)


print("hello")
def main(prg):
    prg.ground([("base", [])], context=Context())
    prg.solve()
#end.

% Using the Python function in an ASP atom.
result(@helper(5)).
result(@helper(10)).
result(6).

% Uncomment the following line if you want to explicitly show the result/1 predicate:
#show result/1.