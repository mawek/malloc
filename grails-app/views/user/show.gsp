<%@ page import="malloc.User"%>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />

	<!-- popis v liste - detail uzivatela -->	
	<title>
		<g:message code="user.detail.label" />
	</title>
</head>

<body>
	<div class="body">
	
		<!-- nadpis - detail uzivatela -->
		<h1>
			<g:message code="user.detail.label" />: ${fieldValue(bean: user, field: "code")} - ${fieldValue(bean: user, field: "name")} ${fieldValue(bean: user, field: "surname")} (<a href="mailto:${fieldValue(bean: user, field: 'email')}">${fieldValue(bean: user, field: "email")}</a>) | <g:link controller="department" action="show" params="${[id:user.department?.id]}">${user.department?.code}</g:link> 
		</h1>
				
		<div>
			<g:link action="edit"  controller="user" id="${user.id}">
					(<g:message code="user.edit.label" />)
			</g:link>			
		</div>				
	</div>
	
	<g:include controller="allocation" action="my" params="[userId:user.id]"/>
</body>
</html>
