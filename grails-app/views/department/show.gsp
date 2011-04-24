<%@ page import="malloc.Department"%>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />

	<!-- popis v liste - detail oddelenia -->	
	<title>
		<g:message code="department.detail.label" />
	</title>	
</head>

<body>
	<div class="body">
		
		<!-- nadpis - detail oddelenia -->
		<h1>
			<g:message code="department.detail.label" />: ${fieldValue(bean: department, field: "code")} - ${fieldValue(bean: department, field: "name")}			
		</h1>
		<div>
			<g:link action="edit"  controller="department" id="${department.id}">
					(<g:message code="department.edit.label" />)
			</g:link>			
		</div>
		
		<!-- flash spravy -->
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		
		<h2>
			<span>
				<g:message code="department.teamLeader.label" default="Team Leader" />:
				<g:link action="show"  controller="user" id="${department.teamLeader?.id}">
					 ${department?.teamLeader?.encodeAsHTML()}
				</g:link>
			</span>
		</h2>		
		
		
		<div class="dialog">
			<span>${fieldValue(bean: department, field: "description")}</span>			
		</div>
		
		<br/>
		<div class="members">
			<h2><g:message code="department.members.label" />:</h2>
			<span>
				<g:each in="${department.members}" status="i" var="member">
					<g:if test="${i>0}">
						,
					</g:if>
					
					<g:link action="show"  controller="user" id="${member.id}">
						${member}
					</g:link>
				</g:each>
			</span>			
		</div>
	</div>
</body>
</html>
