<br />
<table>
	<thead>
		<tr>
			<th>
				${discussion.user}
			</th>
			<th><g:formatDate date="${discussion.date?.toDate()}" format="dd.MM.yyyy HH:mm:ss" /></th>
			<th><g:formRemote name="deleteDisc" url="[controller:'discussion',action:'delete']" update="discussionList"
					enctype="multipart/form-data">
					<g:hiddenField name="id" value="${discussion.id}" />
					<g:hiddenField name="allocationId" value="${discussion.allocation.id}" />

					<span class="button"> <g:submitButton name="delete" class="save"
							value="${message(code: 'discussion.button.delete.label', default: 'Delete')}"
							onClick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /> </span>

				</g:formRemote></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				${discussion.note?.encodeAsHTML()}
			</td>

		</tr>
	</tbody>
</table>


