repl:
  nix repl .

alias sw := switch
switch *ARGS:
  nh os switch . {{ARGS}}

switch-doctor:
  nh os switch ".#doctor" {{ARGS}}
