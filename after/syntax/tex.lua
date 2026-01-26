-- Custom syntax matching for LaTeX math symbols to distinguish them from generic commands
-- This file is loaded after standard syntax files, ensuring these rules override defaults.

vim.cmd([[
  syn match texMathSymbol "\\\v(alpha|beta|gamma|delta|epsilon|varepsilon|zeta|eta|theta|vartheta|iota|kappa|lambda|mu|nu|xi|pi|rho|varrho|sigma|varsigma|tau|upsilon|phi|varphi|chi|psi|omega|Gamma|Delta|Theta|Lambda|Xi|Pi|Sigma|Upsilon|Phi|Psi|Omega)" containedin=texMathCmd
  syn match texMathSymbol "\\\v(nabla|partial|infty|emptyset|ell|hbar|imath|jmath|wp|Re|Im)" containedin=texMathCmd
  syn match texMathSymbol "\\\v(forall|exists|nexists|in|ni|notin|subset|supset|subseteq|supseteq|cap|cup|vee|wedge|neg|cong|equiv|sim|simeq|approx|ne|neq|le|ge|leq|geq)" containedin=texMathCmd
  syn match texMathSymbol "\\\v(rightarrow|leftarrow|Rightarrow|Leftarrow|mapsto|longmapsto|iff|to|gets|cdot|times|circ|bullet|star|ast)" containedin=texMathCmd
  syn match texMathSymbol "\\\v(sum|prod|coprod|int|iint|iiint|oint)" containedin=texMathCmd
]])
