{
  delib,
  host,
  ...
}:
delib.module {
  name = "types.baremetal";

  options = delib.singleEnableOption host.isBaremetal;
}
