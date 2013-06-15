#! /usr/bin/env ruby

# f(x) = 31172433x^(-1.18)
# log_10 C = 7.493770700167062

def f_x(x)
  31172433.76*(x**(-1.18))
end

def inverse_f_x(frequency)
  10**((Math.log10(frequency) - 7.493770710755386)/(-1.18))
end
