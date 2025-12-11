{ ... }:

{
  languages.c = {
    enable = true;
    debugger = true;
  };

  env = {
    CC = "gcc";
    CXX = "g++";
  };
}
