package malloc

/*
 * multicheckbox: http://stackoverflow.com/questions/2806101/grails-simple-hasmany-problem-using-checkboxes-rather-than-html-select-in-cre
 * */
class DepartmentController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[departmentList: Department.list(params), departmentTotal: Department.count()]
	}

	def create = {
		def department = new Department()
		department.properties = params
		return [department: department]
	}

	def save = {
		def department = Department.get(params.id)
		def create = false
		if (department) {
			if (params.version) {
				def version = params.version.toLong()
				if (department.version > version) {

					department.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'department.label', default: 'Department')]
					as Object[], "Another user has updated this Department while you were editing")
					render(view: "edit", model: [department: department])
					return
				}
			}
			department.properties = params
		}else{
			department = new Department(params)
			create = true
		}

		if (!department.hasErrors() && department.save()) {
			department.members.each{ it.department = null }
			department?.members?.clear()
			params.each {
				if (it.key.startsWith("member")){
					User.get((it.value) as Integer).department = department
				}
			}

			if(create){
				flash.message = "${message(code: 'department.created.message', args: [department.code])}"
			}else{
				flash.message = "${message(code: 'department.updated.message', args: [department.code])}"
			}
			redirect(action: "show", id: department.id)
		} else {
			render(view: "create", model: [department: department])
		}
	}

	def show = {
		def department = Department.get(params.id)
		if (!department) {
			flash.message = "${message(code: 'department.not.found.message', args: [params.id])}"
			redirect(action: "list")
		}
		else {
			[department: department]
		}
	}

	def edit = {
		def departmentInstance = Department.get(params.id)
		if (!departmentInstance) {
			flash.message = "${message(code: 'department.not.found.message', args: [params.id])}"
			redirect(action: "list")
		}
		else {
			render(view: 'create', model:[department: departmentInstance])
		}
	}



	def delete = {
		def departmentInstance = Department.get(params.id)
		if (departmentInstance) {
			try {
				departmentInstance.delete(flush: true)
				flash.message = "${message(code: 'department.deleted.message', args: [department.code])}"
				//				redirect(action: "list")
				redirect(url: request.getHeader('referer'))
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'department.not.deleted.message', args: [department.code])}"
				//				redirect(action: "show", id: params.id)
				redirect(url: request.getHeader('referer'))
			}
		}
		else {
			flash.message = "${message(code: 'department.not.found.message', args: [params.id])}"
			//			redirect(action: "list")
			redirect(url: request.getHeader('referer'))
		}
	}
}
