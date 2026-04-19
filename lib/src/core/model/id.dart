extension type const VmId(Object value) {
  VmId.fromString(String value) : this(value);
}

extension type const VmId$String(String value) implements VmId {
  VmId$String.fromString(String value) : this(value);
}

extension type const VmId$Int(int value) implements VmId {
  VmId$Int.fromString(String value) : this(int.parse(value));
}
