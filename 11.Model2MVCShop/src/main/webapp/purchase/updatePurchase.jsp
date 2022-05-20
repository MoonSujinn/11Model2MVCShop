<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
body {
	padding-top: 50px;
}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= "����"  Event ���� =============
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button.btn.btn-primary").on("click", function() {
			fncUpdatePurchase();
		});
	});

	//============= "���"  Event ó�� ��  ���� =============
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click", function() {
			$("form")[0].reset();
		});
	});

	///////////////////////////////////////////////////////////////////////
	function fncUpdatePurchase() {

		//Form ��ȿ�� ����
		//var name = document.detailForm.prodName.value;
		//var detail = document.detailForm.prodDetail.value;
		//var manuDate = document.detailForm.manuDate.value;
		//var price = document.detailForm.price.value;

		var receiverName=$("input[name='receiverName']").val();
   		var receiverPhone=$("input[name='receiverPhone']").val();
   		var divyAddr=$("input[name='divyAddr']").val();
   			   
			if(receiverName == null || receiverName.length<1){
 			alert("�������̸��� �ݵ�� �Է��ϼž� �մϴ�.");
  			return;
			}	 
   		if(receiverPhone == null || receiverPhone.length<1){
     		alert("�����ڿ���ó�� �ݵ�� �Է��ϼž� �մϴ�.");
      		return;
   		}	   
   		if(divyAddr == null || divyAddr.length<1){
      		alert("�������ּҴ� �ݵ�� �Է��ϼž� �մϴ�.");
      		return;
   		}

		//document.detailForm.action='/product/updateProduct';
		//document.detailForm.submit();
		$("form").attr("method", "POST").attr("action",
				"/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
	}
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

		<div class="page-header text-center">
			<h3 class=" text-info">������������</h3>
			<h5 class="text-muted">
				���� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.
			</h5>
		</div>

		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">���Ź�ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="tranNo" name="tranNo" value="${purchase.tranNo }" placeholder="���Ź�ȣ"  readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">���Ź�ȣ�� �����Ұ�</strong>
		      </span>
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
				<label for="prodDetail"
					class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverName"
						name="receiverName" value="${purchase.receiverName}"
						placeholder="���汸�����̸�">
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail"
					class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverPhone"
						name="receiverPhone" value="${purchase.receiverPhone}"
						placeholder="���汸�����̸�">
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail"
					class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyAddr"
						name="divyAddr" value="${purchase.divyAddr}"
						placeholder="���汸�����ּ�">
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail"
					class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest"
						name="divyRequest" value="${purchase.divyRequest}"
						placeholder="���汸�ſ�û����">
				</div>
			</div>

			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
				<div class="col-sm-4">
					<input type="text" id="datePicker" class="form-control"
						id="divyDate" name="divyDate" value="${purchase.divyDate}"
						placeholder="�������������">
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
					<a class="btn btn-primary btn" href="#" role="button">�� &nbsp;��</a>
				</div>
			</div>
		</form>
		<!-- form Start /////////////////////////////////////-->

	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>