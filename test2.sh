set -euo pipefail                                                                                                                                          

  for f in *; do                                                                                                                                             
  p="$(pwd)/$f"                                                                                                                                              
  [ -e "$p" ] || continue                                                                                                                                    
  sys=$(uname -s 2>/dev/null || printf Linux)                                                                                                                
  if [ "$sys" = "Darwin" ]; then                                                                                                                             
  u=$(stat -f %Su "$p" 2>/dev/null || { set -- $(ls -ld "$p" 2>/dev/null); echo "$3"; } || echo "")                                                          
  else                                                                                                                                                       
  u=$(stat -c %U "$p" 2>/dev/null || { set -- $(ls -ld "$p" 2>/dev/null); echo "$3"; } || echo "")                                                           
  fi                                                                                                                                                         
  printf "%s\t%s\n" "$p" "$u"                                                                                                                                
  done