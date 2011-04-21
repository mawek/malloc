<%@ page import="malloc.Department"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title><g:message code="department.list.label" /></title>
</head>
<body>
	<div class="nav">
		<span class="menuButton"><g:link class="create" action="create">
				<g:message code="department.new.label" />
			</g:link> </span>
	</div>
	<div class="body">
		<h1>
			<g:message code="department.list.label" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="list">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="code" title="${message(code: 'department.code.label', default: 'Code')}" />

						<g:sortableColumn property="name" title="${message(code: 'department.name.label', default: 'Name')}" />

						<g:sortableColumn property="description" title="${message(code: 'department.description.label', default: 'Description')}" />

						<th><g:message code="department.teamleader.label" default="Team Leader" /></th>
						<th></th>

					</tr>
				</thead>
				<tbody>
					<g:each in="${departmentList}" status="i" var="department">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td>
								<g:link action="show" id="${department.id}">
									${fieldValue(bean: department, field: "code")}
								</g:link>								
							</td>

							<td>
								<g:link action="show" id="${department.id}">
									<g:shortly value='${fieldValue(bean: department, field: "description")}'/>
								</g:link>																								
							</td>


							<td>
								<g:shortly value='${fieldValue(bean: department, field: "description")}'/>
							</td>

							<td >
								<g:link action="show" controller="user" id="${department.teamLeader?.id}">
									${fieldValue(bean: department, field: "teamLeader")}
								</g:link>								
							</td>
							<td width="10%">								
								<g:form>
                    				<g:hiddenField name="id" value="${department?.id}" />
                    				<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    				
                    				<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'department.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                				</g:form>                				
							</td>

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div class="paginateButtons">
			<g:paginate total="${departmentTotal}" />
		</div>
	</div>
</body>
</html>
