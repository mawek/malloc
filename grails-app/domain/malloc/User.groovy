package malloc

class User {

	static constraints = {
		code(blank:false, size:3..3,unique:true)
		name(blank:false)
		surname(blank:false)
		email(email:true,unique:true)
		department(nullable:true)
		allocations(nullable:true)
		requests(nullable:true)
		approvals(nullable:true)
		photoPath(nullable:true)
	}

	static hasMany = [allocations:Allocation, requests:Allocation, approvals:Allocation]
	static mappedBy = [allocations:'worker', requests:'requester', approvals:'approver']

	String name
	String surname
	String code
	String email
	Department department
	String photoPath

	@Override
	public String toString(){
		"$code - $name $surname"
	}
}
