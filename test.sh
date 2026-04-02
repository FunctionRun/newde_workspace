set -euo pipefail                                                                                                                                          

  dir="$PWD"                                                                                                                                                 
  names=()                                                                                                                                                   
  for f in *; do                                                                                                                                             
  [ -d "$f" ] || continue                                                                                                                                    
  case "$f" in .git|.github|node_modules) continue;; esac                                                                                                    
  names+=("$f")                                                                                                                                              
  done                                                                                                                                                       

  for f in "${names[@]}"; do                                                                                                                                 
  base="$dir/$f"                                                                                                                                             
  br=""                                                                                                                                                      
  [ -d "$base" ] || continue                                                                                                                                 
  if command -v git >/dev/null 2>&1 && git -C "$base" rev-parse --is-inside-work-tree >/dev/null 2>&1; then                                                  
  root=$(git -C "$base" rev-parse --show-toplevel 2>/dev/null || echo "")                                                                                    
  if [ -n "$root" ] && [ "$root" = "$base" ]; then                                                                                                           
  br=$(git -C "$base" symbolic-ref --short -q HEAD 2>/dev/null || git -C "$base" rev-parse --short HEAD 2>/dev/null)                                         
  fi                                                                                                                                                         
  fi                                                                                                                                                         
  lower=$(printf "%s" "$br" | tr A-Z a-z)                                                                                                                    
  if [ -n "$br" ] && [ "$br" != "HEAD" ] && ! printf "%s" "$lower" | grep -Eq "^(fatal|error:)"; then                                                        
  printf "%s\t%s\n" "$base" "$br"                                                                                                                            
  fi                                                                                                                                                         
  done