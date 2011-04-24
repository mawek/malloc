<%@ page import="malloc.Allocation"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title><g:message code="allocation.list.label" /></title>
</head>
<body>
	<div class="nav">	
		<span class="menuButton"><g:link class="create" action="create">
				<g:message code="allocation.new.label" />
			</g:link> </span>
	</div>
	<div class="body">
		<h1>
			<g:message code="allocation.list.label" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="list">
			<table>
				<thead>
					<tr >						

						<g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />						
						
						<g:sortableColumn property="status" title="${message(code: 'allocation.status.label', default: 'Status')}" />

						<th><g:message code="allocation.requester.label" default="Requester" /></th>
						
						<th><g:message code="allocation.worker.label" default="Worker" /></th>
						
						<th><g:message code="allocation.approver.label" default="Approver" /></th>

						<g:sortableColumn property="startDate" title="${message(code: 'allocation.startDate.label', default: 'Start date')}" />
						
						<th><!-- buttony na editaciu/zmazanie --></th>	
					</tr>
				</thead>
				<tbody>
					<g:each in="${allocationList}" status="i" var="allocation">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">							

							<td>
								<g:link action="show" id="${allocation.id}">
									<g:shortly value='${fieldValue(bean: allocation, field: "name")}'/>								
								</g:link>
							</td>							
							
							<td>
								${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}
							</td>

							<td>
								<g:link action="show"  controller="user" id="${allocation.requester?.id}">
									${allocation.requester?.code}
								</g:link>
							</td>

							<td>
								<g:link action="show"  controller="user" id="${allocation.worker?.id}">
									${allocation.worker?.code}
								</g:link>
							</td>

							<td>
								<g:link action="show"  controller="user" id="${allocation.approver?.id}">
									${allocation.approver?.code}
								</g:link>	
							</td>
							
							<td>
								<g:formatDate date="${allocation.startDate?.toDate()}" format="dd.MM.yyyy" /> 
							</td>	
							
							<td width="10%" style="line-height: 1.5em;">																
									<g:link controller="allocation" action="edit" params="${[id:allocation.id]}" ><g:message code="default.button.edit.label" default="Edit" /></g:link>
									<br/>
									<g:link controller="allocation" action="delete" params="${[id:allocation.id]}" onclick="return confirm('${message(code: 'allocation.button.delete.confirm.message', default: 'Are you sure?')}');"><g:message code="default.button.delete.label" default="Delete" /></g:link>
							</td>
				

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div class="paginateButtons">
			<g:paginate total="${allocationTotal}" />
		</div>
	</div>
	<br/>
	<div class="nav">
		<span class="menuButton"><g:link class="create" action="create">
				<g:message code="allocation.new.label" />
			</g:link> </span>
	</div>
</body>
</html>
