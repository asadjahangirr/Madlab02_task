# CS442 — Campus Library System: Reflection Answers

Name: ASADJAHANGIRR  
Roll Number: 04072313036

**Q1. What can a subclass using extends use for free that a class using implements has to write itself?**  
A subclass using `extends` inherits the parent class's concrete fields and methods. A class using `implements` must provide the required interface members itself.

**Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?**  
I would use a mixin to share renewal behavior between selected classes. I would use an abstract parent class when classes share a common identity and must implement the same core methods.

**Q3. Why must you override hashCode whenever you override ==?**  
Objects that compare equal must have the same hash code. Otherwise, sets and maps may treat equal objects as separate values.

**Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?**  
An extension adds methods to `String` without inheriting or changing its implementation. Dart's built-in `String` type cannot be extended as a subclass.
