package malloc

class Department {

	static constraints = {
		name(blank:false)
		code(blank:false,unique:true)
		description(blank:true)
		teamLeader(nullable:true)
	}

	String code
	String name
	String description
	User teamLeader
	static hasMany = [members:User]

	@Override
	public String toString(){
		"$code - $name"
	}
}
