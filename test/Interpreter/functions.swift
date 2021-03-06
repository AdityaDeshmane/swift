// RUN: %target-run-simple-swift | FileCheck %s
// REQUIRES: executable_test

func double(x: Int) -> Int {
  return x+x
}

func curriedSubtract(x: Int)(_ y: Int) -> Int {
  return x-y
}

func twice(f: (Int) -> Int, _ x: Int) -> Int {
  return f(f(x))
}

// CHECK: 4
print(double(2))
// CHECK: 8
print(double(4))

// CHECK: 12
print(curriedSubtract(16)(4))

// CHECK: 20
print(twice(double, 5))
// CHECK: 7
print(twice({ $0 + 1 }, 5))
// CHECK: 3
print(twice({ x in x - 1 }, 5))

// <rdar://problem/22044607>
class C {}
class D : C {}

func foo(a: Any, p2: Bool = true) { print("Wrong") }
func foo(c: C) { print("Right") }

func bar(a: Any..., p2: Bool = true) { print("Wrong") }
func bar(c: C) { print("Right") }

// CHECK: Right
foo(D())
// CHECK: Right
bar(D())