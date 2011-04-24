<%@ page import="malloc.Allocation"%>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="layout" content="main" />
	
	<!-- popis v liste zoznam alokacii aktualneho uzivatela -->
	<title>
		<g:message code="allocation.list.label" />
	</title>
</head>

<body>

	<!-- zobrazenie flashu -->
	<g:if test="${flash.message}">
		<div class="message">
			${flash.message}
		</div>
	</g:if>
	<br />

	<!-- link na vytvorenie novej ziadosti o alokaciu -->
	<div class="nav">
		<span class="menuButton"> 
			<g:link class="create" action="create" params="${['worker.id':user.id, 'approver.id':user.department?.teamLeader?.id]}">
				<g:message code="allocation.new.label" />
			</g:link> 
		</span>
	</div>

	<!-- alokacie na mna (alebo na aktualneho uzivatela) -->
	<div class="body">
		<h1>
			<g:message code="allocation.list.my.allocations.label" args="${[user.code, user.name,user.surname]}" default="Users allocations" />
		</h1>

		<div class="list">
			<table>
				<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />

						<g:sortableColumn property="type" title="${message(code: 'allocation.type.label', default: 'Type')}" />

						<g:sortableColumn property="status" title="${message(code: 'allocation.status.label', default: 'Status')}" />

						<th>
							<g:message code="allocation.requester.label" default="Requester" />
						</th>

						<th>
							<g:message code="allocation.approver.label" default="Approver" />
						</th>

						<g:sortableColumn property="startDate" title="${message(code: 'allocation.startDate.label', default: 'Start date')}" />

						<th><!-- buttony na editaciu/zmazanie --></th>

					</tr>
				</thead>
				<tbody>
					<g:each in="${myAllocations}" status="i" var="allocation">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td>
								<g:link action="show" id="${allocation.id}">
									<g:shortly value='${fieldValue(bean: allocation, field: "name")}' />
								</g:link>
							</td>

							<td>
								${message(code: 'allocation.type.'+allocation?.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}
							</td>

							<td>
								${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}
							</td>

							<td>
								<g:link action="show" controller="user" id="${allocation.requester?.id}">
									${allocation.requester?.code}
								</g:link>
							</td>


							<td>
								<g:link action="show" controller="user" id="${allocation.approver?.id}">
									${allocation.approver?.code}
								</g:link>
							</td>
							
							<td>
								<g:formatDate date="${allocation.startDate?.toDate()}" format="dd.MM.yyyy" />
							</td>
							
							<td width="10%">
								<g:form>
									<g:hiddenField name="id" value="${allocation?.id}" />
									<span class="button">
										<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /> 
									</span>
									<br />
									
									<span class="button">
										<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'allocation.button.delete.confirm.message', default: 'Are you sure?')}');" /> 
									</span>
								</g:form>
							</td>

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>


	<br />
	<br />
	<br />

	<!-- moje schvalovanie alokacii -->
	<div class="body">
		<h1>
			<g:message code="allocation.list.my.approvals.label" args="${[user.code, user.name,user.surname]}" default="Allocations waiting for aproval" />
		</h1>

		<div class="list">
			<table>
				<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />

						<g:sortableColumn property="type" title="${message(code: 'allocation.type.label', default: 'Type')}" />

						<g:sortableColumn property="status" title="${message(code: 'allocation.status.label', default: 'Status')}" />

						<th>
							<g:message code="allocation.requester.label" default="Requester" />
						</th>

						<th>
							<g:message code="allocation.worker.label" default="Worker" />
						</th>

						<g:sortableColumn property="startDate" title="${message(code: 'allocation.startDate.label', default: 'Start date')}" />
						
						<th><!-- buttony na editaciu/zmazanie --></th>

					</tr>
				</thead>
				
				<tbody>
					<g:each in="${myApprovals}" status="i" var="allocation">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td>
								<g:link action="show" id="${allocation.id}">
									<g:shortly value='${fieldValue(bean: allocation, field: "name")}' />
								</g:link>
							</td>

							<td>
								${message(code: 'allocation.type.'+allocation?.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}
							</td>

							<td>
								${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}
							</td>

							<td>
								<g:link action="show" controller="user" id="${allocation.requester?.id}">
									${allocation.requester?.code}
								</g:link>
							</td>

							<td>
								<g:link action="show" controller="user" id="${allocation.worker?.id}">
									${allocation.worker?.code}
								</g:link>
							</td>

							<td>
								<g:formatDate date="${allocation.startDate?.toDate()}" format="dd.MM.yyyy" />
							</td>
							
							<td width="10%">
								<g:form>
									<g:hiddenField name="id" value="${allocation?.id}" />
									<span class="button">
										<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /> 
									</span>
									<br />
									
									<span class="button">
										<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'allocation.button.delete.confirm.message', default: 'Are you sure?')}');" /> 
									</span>
								</g:form>
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
	<br />
	<br />
	<br />
	
	<!-- ziadost o alokacie -->
	<div class="body">
		<h1>
			<g:message code="allocation.list.my.requests.label" args="${[user.code, user.name,user.surname]}" default="User allocation requests" />
		</h1>

		<div class="list">
			<table width="80%">
				<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />

						<g:sortableColumn property="type" title="${message(code: 'allocation.type.label', default: 'Type')}" />

						<g:sortableColumn property="status" title="${message(code: 'allocation.status.label', default: 'Status')}" />

						<th>
							<g:message code="allocation.worker.label" default="Worker" />
						</th>

						<th>
							<g:message code="allocation.approver.label" default="Approver" />
						</th>

						<g:sortableColumn property="startDate" title="${message(code: 'allocation.startDate.label', default: 'Start date')}" />
						
						<th><!-- buttony na editaciu/zmazanie --></th>
					</tr>
				</thead>
				<tbody>
					<g:each in="${myRequests}" status="i" var="allocation">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td>
								<g:link action="show" id="${allocation.id}">
									<g:shortly value='${fieldValue(bean: allocation, field: "name")}' />
								</g:link>
							</td>

							<td>
								${message(code: 'allocation.type.'+allocation?.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}
							</td>

							<td>
								${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}
							</td>

							<td>
								<g:link action="show" controller="user" id="${allocation.worker?.id}">
									${allocation.worker?.code}
								</g:link>
							</td>

							<td>
								<g:link action="show" controller="user" id="${allocation.approver?.id}">
									${allocation.approver?.code}
								</g:link>
							</td>
							
							<td>
								<g:formatDate date="${allocation.startDate?.toDate()}" format="dd.MM.yyyy" />
							</td>
							
							<td width="10%">
								<g:form>
									<g:hiddenField name="id" value="${allocation?.id}" />
									<span class="button">
										<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /> 
									</span>
									<br />
									
									<span class="button">
										<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'allocation.button.delete.confirm.message', default: 'Are you sure?')}');" /> 
									</span>
								</g:form>
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>
