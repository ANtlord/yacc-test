class ClassNoBody;
class ClassWithBody {

}
class ClassWithConstructor {
	this();
}
class ClassWithParametrizedConstructor {
	this(int a);
}
class ClassWithConstructorSet {
	this();
	this(int a);
	this(char a, in uint b);
	this(const ref char a, in uint b);
	this(const ref char a, in uint b) const;
	this() @safe @nogc;
	this(const ref char a, in uint b) @disable;
}
