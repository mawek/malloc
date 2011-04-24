<%@ page import="malloc.User"%>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />

	<!-- popis v liste vytvorenia/zalozenia uzivatela -->	
	<title>
		<g:message code="user.detail.label" />
	</title>
</head>

<body>
	<div class="body">
	
		<!-- nadpis vytvorenia/zalozenia uzivatela -->
		<h1>
			<g:message code="user.detail.label" />: ${fieldValue(bean: user, field: "code")} - ${fieldValue(bean: user, field: "name")} ${fieldValue(bean: user, field: "surname")} (<a href="mailto:${fieldValue(bean: user, field: 'email')}">${fieldValue(bean: user, field: "email")}</a>)
		</h1>
				
		<div>
			<g:link action="edit"  controller="user" id="${user.id}">
					(<g:message code="user.edit.label" />)
			</g:link>			
		</div>
		
		<!-- zobrazenie flashu -->
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>		
	</div>
</body>
</html>
