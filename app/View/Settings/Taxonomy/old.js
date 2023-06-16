<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title><%= APP_NAME ? APP_NAME +' — ' : '' %> Taxonomy</title>
	<% include ../../Include/head %>

</head>
<body>
	<div id="app">
	<% include ../../Include/header %>
	
	<% include ../../Include/aside %>

	<main v-bind:class="fluid ? 'full-width':''">
		<!-- Inline Template -->
		<setting-taxonomy inline-template>
			<!-- Wrapper -->
			<div class="wrapper">
				<!-- Breadcrumb -->
				<div class="bread-crumb">
					<ol>
						<li class="breadcrumb-item"><a href="<%= baseUrl %>" class="">Dashboard</a></li>
						<li class="breadcrumb-item"><span class="active">Taxonomy</span></li>
					</ol>
					<a href="javascript:void(0);" class="btn btn-primary btn-sm" v-on:click="openModal()"><i class="mdi mdi-plus"></i> New</a>
				</div><!-- Breadcrumb -->

				
				<!-- App Container -->
				<div class="app-container">
					<div class="row">
						<div class="col">
							<h5>Taxonomy Record</h5>
							<% if(record.length > 0){ %>
							<div class="card">
								<table class="table noborder-top">
									<thead class="bg-light">
										<tr>
											<th>Title</th>
											<th>Code</th>
											<th width="100" class="text-center">Status</th>
											<th width="100" class="text-center">Action</th>
										</tr>
									</thead>
									<tbody>
										<% for(let key in record){ %>
										<tr>
											<td><%- record[key]['title'] %></td>
											<td><%= record[key]['code'] %></td>
											<td class="text-center"><%- record[key]['status'] == 1 ? '<span class="status active"></span> Active' : '<span class="status"></span> Inactive' %></td>
											<td class="text-center action">
												<% /*<a href="javascript:void(0);"><i class="mdi mdi-arrow-up"></i></a>
												<a href="javascript:void(0);"><i class="mdi mdi-arrow-down"></i></a> */ %>
												<a href="javascript:void(0);" class="btn btn-outline-success" title="edit" v-on:click="edit(<%= record[key]['id'] %>)"><i class="mdi mdi-pen"></i></a>
											</td>
										</tr>
										<% } %>
									</tbody>
								</table>
							</div>
							<% }else{ %>
							<div class="norecord">
								<i class="mdi mdi-information-outline"></i>
								<p>Sorry, we couldn't find any matches.</p>
							</div>
							<% } %>
						</div>
					</div>

					<!-- Modal -->
					<% include ./components/form %>
					<!-- Modal -->

				</div><!-- App Container -->

				<% include ../../Include/alert %>

			</div> <!-- Wrapper -->

		</setting-taxonomy> <!-- Inline Template -->
		
	</main>
	
	</div>
	<% include ../../Include/javascript %>
</body>
</html>