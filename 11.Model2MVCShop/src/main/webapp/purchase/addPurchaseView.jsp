<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="EUC-KR">

<!-- ���� : http://getbootstrap.com/css/   ���� -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
body>div.container {
	border: 3px solid #D6CDB7;
	margin-top: 10px;
}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript" src="../javascript/calendar.js"></script>
<script type="text/javascript">
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button.btn.btn-primary").on("click", function() {
			fncAddPurchase();
		});
	});

	//============= "���"  Event ó�� ��  ���� =============
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click", function() {
			history.go(-1);
		});
	});

	function fncAddPurchase() {


		var receiverName = $("input[name='receiverName']").val();
		var receiverPhone = $("input[name='receiverPhone']").val();
		var divyAddr = $("input[name='divyAddr']").val();


		if (receiverName == null || receiverName.length < 1) {
			alert("�������̸��� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (receiverPhone == null || receiverPhone.length < 1) {
			alert("�����ڿ���ó�� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (divyAddr == null || divyAddr.length < 1) {
			alert("�������ּҴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		$("form").attr("method", "POST")
				.attr("action", "/purchase/addPurchase").submit();
	}
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
		<div class="container">
			<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		</div>
	</div>
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<h1 class="bg-primary text-center">�� ǰ �� ��</h1>

		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">

			<div class="form-group">
				<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodNo" name="prodNo"
						value="${product.prodNo}" placeholder="��ǰ��ȣ" readonly>${purchase.purchaseProd.prodNo}
				</div>
			</div>

			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName"
						name="prodName" value="${product.prodName}" placeholder="��ǰ��"
						readonly>
				</div>
			</div>

			<div class="form-group">
				<label for="prodDetail"
					class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail"
						name="prodDetail" value="${product.prodDetail}"
						placeholder="��ǰ������" readonly>
				</div>
			</div>

			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate"
						name="manuDate" value="${product.manuDate}" placeholder="��������"
						readonly>
				</div>
			</div>

			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price"
						value="${product.price}" placeholder="����" readonly>
				</div>
			</div>


			<div class="form-group">
				<label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="regDate" name="regDate"
						value="${product.regDate}" placeholder="�������" readonly>
				</div>
			</div>

			<div class="form-group">
				<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userId" name="userId"
						value="${user.userId}" placeholder="�����ھ��̵�" readonly>
				</div>
			</div>


      <div class="form-group">
            <label for="paymentOption"
               class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
            <div class="col-sm-4">
			<select 	name="paymentOption"		class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20">
				<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
			</select>
            </div>
         </div>


			<div class="form-group">
				<label for="receiverName"
					class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverName"
						name="receiverName" value="${purchase.receiverName}"
						placeholder="�������̸�">
				</div>
			</div>


			<div class="form-group">
				<label for="receiverPhone"
					class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverPhone"
						name="receiverPhone" value="${purchase.receiverPhone}"
						placeholder="�����ڿ���ó">
				</div>
			</div>

			<div class="form-group">
				<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyAddr"
						name="divyAddr" value="${purchase.divyAddr}" placeholder="�������ּ�">
				</div>
			</div>

			<div class="form-group">
				<label for="divyRequest"
					class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest"
						name="divyRequest" value="${purchase.divyRequest}"
						placeholder="���ſ�û����">
				</div>
			</div>

			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
				<div class="col-sm-4">
					<input type="text" id="datePicker" class="form-control"
						id="divyDate" name="divyDate" value="${purchase.divyDate}"
						placeholder="����������">
				</div>
			</div>

			<script
				src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js">
				
			</script>
			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js">
				
			</script>
			<script type="text/javascript">
				$('#datePicker').datepicker({
					format : "yyyy-mm-dd", // �޷¿��� Ŭ���� ǥ���� �� ����
					language : "kr" // ���(js �߰��� �ʿ��ϴ�.)
				});

				$('#click-btn').on('click', function() {
					var date = $('#dateRangePicker').val();
					alert(date);
				});
			</script>


			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" class="btn btn-primary">�� &nbsp;��</button>
					<a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
				</div>
			</div>
		</form>
		<!-- form Start /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>