<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //메뉴.aspx > 예약하러가기
        string target = Request["target"];
        if(String.Equals(target,"reserve"))
        {
            MultiView1.ActiveViewIndex = 1;
            MultiView2.ActiveViewIndex = -1;
            MultiView3.ActiveViewIndex = -1;
        }

        Master_Login();

        //게시글 로드
        string uid = Request["uid"];
        if(uid != null)
        {
            //게시글 보기
            MultiView1.ActiveViewIndex = 5;

            Board board = new Board();
            board.SelectBoard(uid);
            Label31.Text = board.uid.ToString();
            Label32.Text = board.subject.ToString();
            Label33.Text = board.reg_date.ToString();
            Label34.Text = board.name.ToString();
            Label35.Text = board.comment.ToString();
            Label36.Text = board.password.ToString();
            Label37.Text = board.ref1.ToString();
        }
    }

    //관리자 로그인
    protected void Master_Login()
    {
        if(Session["Master"] != null)
        {
            Button1.Visible = true;

            MultiView1.ActiveViewIndex = -1;
            MultiView2.ActiveViewIndex = -1;
            MultiView3.ActiveViewIndex = 0;

            //회원목록 부르기
            Member member = new Member();
            DataSet ds = member.SelectMembers();
            GridView3.DataSource = ds;
            GridView3.DataBind();
        }
    }

    //관리자 로그아웃
    protected void Button1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = -1;
        String msg = "관리자 LOGOUT";

        Script script = new Script();
        script.MsgBox(msg, Page);

        Button1.Visible = false;
        Session.Contents.RemoveAll();
    }

    //원스하우스 소개 URL이동
    protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(string.Format("menu.aspx?target=" + "introduction"));
    }

    //시설&객신안내 URL이동
    protected void ImageButton5_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(string.Format("menu.aspx?target=" + "information"));
    }

    //이용안내&예약 URL이동
    protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(string.Format("menu.aspx?target=" + "guide"));
    }

    //저녁식사 URL이동
    protected void ImageButton7_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(string.Format("menu.aspx?target=" + "dinner"));
    }

    //찾아가는길 URL이동
    protected void ImageButton8_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(string.Format("menu.aspx?target=" + "introduction"));
    }

    //예약하기
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if(Session["Master"] != null)
        {
            MultiView3.ActiveViewIndex = -1;
        }
        MultiView1.ActiveViewIndex = 1;
    }

    //예약확인
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        if(Session["Master"] != null)
        {
            MultiView3.ActiveViewIndex = 0;
        }
        else
        {
            MultiView1.ActiveViewIndex = 2;
        }
    }

    //게시판
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        if(Session["Master"] != null)
        {
            MultiView3.ActiveViewIndex = -1;
        }
        MultiView1.ActiveViewIndex = 3;

        Board board = new Board();
        DataSet ds = board.SelectBoards();

        GridView1.DataSource = ds;
        GridView1.DataBind();
    }

    //이메일
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;

        int email = DropDownList2.SelectedIndex;
        if(email == 2)
        {
            TextBox6.Text = "naver.com";
        }
        else if(email == 3)
        {
            TextBox6.Text = "daum.net";
        }
        else if(email == 4)
        {
            TextBox6.Text = "nate.com";
        }
        else if(email == 5)
        {
            TextBox6.Text = "google.com";
        }

    }

    //객실선택 - 나눔관 5406호 일수
    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;

        int day = DropDownList3.SelectedIndex;
        if(day == 1)
        {
            Label17.Text = "55,000원";
        }
        else if(day == 2)
        {
            Label17.Text = "110,000원";
        }
        else if(day == 3)
        {
            Label17.Text = "165,000원";
        }
    }

    //객실선택 - 나눔관 5421호 일수
    protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;

        int day = DropDownList4.SelectedIndex;
        if(day == 1)
        {
            Label18.Text = "40,000원";
        }
        else if(day == 2)
        {
            Label18.Text = "80,000원";
        }
        else if(day == 3)
        {
            Label18.Text = "120,000원";
        }
    }

    //게시판 페이징
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //새로운 인덱스의 번호를 할당
        GridView1.PageIndex = e.NewPageIndex;
        MultiView1.ActiveViewIndex = 3;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = -1;

        Board board = new Board();
        DataSet ds = board.SelectBoards();

        GridView1.DataSource = ds;
        GridView1.DataBind();
    }

    //글작성 버튼
    protected void Button6_Click(object sender, EventArgs e)
    {
        //게시글 등록 View로 이동
        MultiView1.ActiveViewIndex = 4;
    }

    //게시글 등록
    protected void Button4_Click(object sender, EventArgs e)
    {
        string name = TextBox10.Text;
        string password = TextBox13.Text;
        string subject = TextBox11.Text;
        string comment = TextBox12.Text;
        string register = DateTime.Now.ToString("yyyy.MM.dd");
        int ref1 = 0;
        string msg = "게시글이 정상적으로 등록되었습니다.";
        string errormsg = "오류가 발생하여 게시판으로 돌아갑니다.";

        Board board = new Board();
        Script script = new Script();

        //오류체킹 validator사용X
        if (name.Equals(""))
        {
            msg = "이름을 입력해주세요.";
            script.MsgBox(errormsg, Page);
        }
        else if (password.Equals(""))
        {
            msg = "비밀번호를 입력해주세요.";
            script.MsgBox(errormsg, Page);
        }
        else if (subject.Equals(""))
        {
            msg = "글 제목을 입력해주세요.";
            script.MsgBox(errormsg, Page);
        }
        else
        {
            //게시글 등록
            board.InsertBoard(name, password, subject, comment, register, ref1);
            script.MsgBox(msg, Page);
            TextBox10.Text = "";
            TextBox11.Text = "";
            TextBox12.Text = "";
            TextBox13.Text = "";

            //게시판으로 이동
            MultiView1.ActiveViewIndex = 3;
            DataSet ds = board.SelectBoards();

            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
    }

    //게시글 등록취소
    protected void Button5_Click(object sender, EventArgs e)
    {
        TextBox10.Text = "";
        TextBox11.Text = "";
        TextBox12.Text = "";
        TextBox13.Text = "";

        //게시판으로 이동
        MultiView1.ActiveViewIndex = 3;
    }

    //게시글 글 목록버튼
    protected void Button7_Click(object sender, EventArgs e)
    {
        //게시판으로 이동
        Board board = new Board();
        int uid = int.Parse(Label31.Text);
        int ref1 = int.Parse(Label37.Text);
        board.UpdateRef(uid, ref1);

        DataSet ds = board.SelectBoards();
        GridView1.DataSource = ds;
        GridView1.DataBind();

        MultiView1.ActiveViewIndex = 3;
    }

    //게시글 수정버튼
    protected void Button8_Click(object sender, EventArgs e)
    {
        //게시글 비밀번호 판단할 페이지로 이동
        MultiView1.ActiveViewIndex = 6;
    }

    //게시글 수정-비밀번호 확인
    protected void Button12_Click(object sender, EventArgs e)
    {
        string getPw = Label36.Text;
        string pw = TextBox18.Text;
        Script script = new Script();
        Board board = new Board();

        //비밀번호가 일치할 경우 수정폼으로 이동
        if(getPw.Equals(pw))
        {
            script.MsgBox("비밀번호가 일치합니다.", Page);
            MultiView1.ActiveViewIndex = 7;

            //기존의 정보를 그대로 가져와서 수정이 가능하도록함
            TextBox14.Text = Label34.Text;
            TextBox15.Text = Label32.Text;
            TextBox16.Text = Label35.Text;
        }
        //일치하지 않을경우 게시판으로 이동
        else
        {
            script.MsgBox("비밀번호가 일치하지않습니다. 게시판목록으로 이동합니다.", Page);
            DataSet ds = board.SelectBoards();
            GridView1.DataSource = ds;
            GridView1.DataBind();

            MultiView1.ActiveViewIndex = 3;
        }
    }

    //게시글 수정버튼
    protected void Button10_Click(object sender, EventArgs e)
    {
        int uid = int.Parse(Label31.Text);
        string subject = TextBox15.Text;
        string comment = TextBox16.Text;
        string password = TextBox17.Text;
        string register = DateTime.Now.ToString("yyyy.MM.dd");
        int ref1 = int.Parse(Label37.Text);
        Board board = new Board();
        Script script = new Script();
        board.UpdateBoard(uid, password, subject, comment, register, ref1);

        //게시판으로 돌아가기
        script.MsgBox("정상적으로 수정되었습니다.", Page);
        MultiView1.ActiveViewIndex = 3;

        DataSet ds = board.SelectBoards();

        GridView1.DataSource = ds;
        GridView1.DataBind();
    }

    //게시글 수정비밀번호-취소버튼
    protected void Button13_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 5;
    }

    //게시글 삭제버튼
    protected void Button9_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 8;
    }

    //게시글 수정폼-취소버튼
    protected void Button11_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 5;
    }

    //게시글 삭제 - 비밀번호삭제버튼
    protected void Button14_Click(object sender, EventArgs e)
    {
        int uid = int.Parse(Label31.Text);
        string getPw = Label36.Text;
        string pw = TextBox19.Text;
        Script script = new Script();
        Board board = new Board();

        if(getPw.Equals(pw))
        {
            board.DeleteBoard(uid);
            script.MsgBox("정상적으로 삭제되었습니다.", Page);

            DataSet ds = board.SelectBoards();
            GridView1.DataSource = ds;
            GridView1.DataBind();

            MultiView1.ActiveViewIndex = 3;
        }
        else
        {
            script.MsgBox("비밀번호가 일치하지않습니다. 게시판목록으로 이동합니다.", Page);

            DataSet ds = board.SelectBoards();
            GridView1.DataSource = ds;
            GridView1.DataBind();

            MultiView1.ActiveViewIndex = 3;
        }
    }

    //게시글 삭제 - 비밀번호취소버튼
    protected void Button15_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 5;
    }

    //결제하기(회원가입)
    protected void Button2_Click(object sender, EventArgs e)
    {
        //예약자 이름
        string name = TextBox1.Text;

        //전화번호
        string phone = TextBox2.Text;

        //도착시간
        string time = DropDownList1.SelectedValue;

        //E-mail
        string email = TextBox5.Text + "@" + TextBox6.Text;

        //E-mail수신여부
        string emailcheck = "";
        if (CheckBox1.Checked)
            emailcheck = "o";
        else
            emailcheck = "x";

        //객실선택 + 숙박일 수 + 가격
        string room = "";
        string day = "";
        string price = "";
        //5406호 라디오 체크, 숙박일 수, 가격
        if (RadioButton1.Checked)
        {
            room = "나눔관 5406호";
            day = DropDownList3.SelectedValue;
            price = Label17.Text;
        }
        //5421호 라디오 체크, 숙박일 수, 가격
        if (RadioButton2.Checked)
        {
            room = "나눔관 5421호";
            day = DropDownList4.SelectedValue;
            price = Label18.Text;
        }

        //체크인 날짜
        string checkin = Request.Form["checkin"];

        //체크아웃 날짜
        string checkout = Request.Form["checkout"];

        //결제은행
        string bank = DropDownList5.SelectedValue;

        //결제한 날짜
        string register = DateTime.Now.ToString("yyyy.MM.dd");

        Member member = new Member();
        Script script = new Script();
        string msg = "정상적으로 예약접수되었습니다.";

        member.insertMember(phone, name, time, email, emailcheck, room, day, price, checkin, checkout, bank, register);
        script.MsgBox(msg, Page);

        TextBox1.Text = "";
        TextBox2.Text = "";
        TextBox5.Text = "";
        TextBox6.Text = "";
        CheckBox1.Checked = false;
        DropDownList1.SelectedIndex = 0;
        DropDownList2.SelectedIndex = 0;
        DropDownList3.SelectedIndex = 0;
        DropDownList4.SelectedIndex = 0;
        DropDownList5.SelectedIndex = 0;

        MultiView1.ActiveViewIndex = 0;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = -1;
    }

    //조회하기(로그인)
    protected void Button3_Click(object sender, EventArgs e)
    {
        Boolean flag;
        Script script = new Script();
        Member member = new Member();

        string name = TextBox7.Text;
        string phone = TextBox8.Text;

        if(name.Equals("admin") && phone.Equals(""))
        {
            //관리자 지정 세션 생성
            Session["Master"] = name;
            string msg = "관리자 LOGIN";
            script.MsgBox(msg, Page);

            //회원목록 부르기
            Master_Login();
        }
        else
        {
            flag = member.loginMember(phone, name);

            //회원정보가 있을경우
            if (flag == true)
            {
                Session["name"] = name;
                Session["phone"] = phone;

                string msg = Session["name"] + "님의 예약정보입니다.";
                script.MsgBox(msg, Page);

                TextBox7.Text = "";
                TextBox8.Text = "";
                MultiView1.ActiveViewIndex = -1;
                MultiView2.ActiveViewIndex = 0;
                MultiView3.ActiveViewIndex = -1;
                Label30.Text = name + " 님의 예약정보입니다.";

                //회원목록 부르기
                DataSet ds = member.SelectMember(phone);
                GridView2.DataSource = ds;
                GridView2.DataBind();
            }
            else
            {
                String msg = "예약된 정보가 없습니다.";
                script.MsgBox(msg, Page);
            }
        }


    }

    //예약목록 - 페이징
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;

        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = 0;
        MultiView3.ActiveViewIndex = -1;
    }

    //수정버튼
    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView2.EditIndex = e.NewEditIndex;

        //phone에 맞는 회원정보만 불러오기
        string phone = Session["phone"].ToString();

        Member member = new Member();
        DataSet ds = member.SelectMember(phone);
        GridView2.DataSource = ds;
        GridView2.DataBind();

        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = 0;
        MultiView3.ActiveViewIndex = -1;
    }

    //예약수정
    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string phone = GridView2.DataKeys[e.RowIndex].Value.ToString();
        string time = e.NewValues["time"].ToString();
        string email = e.NewValues["email"].ToString();
        string emailcheck = e.NewValues["emailcheck"].ToString();
        string checkin = e.NewValues["checkin"].ToString();
        string checkout = e.NewValues["checkout"].ToString();
        string msg = "예약정보가 정상적으로 수정되었습니다. 다시 한 번 조회해주세요 ㅠㅠ";

        Member member = new Member();
        Script script = new Script();

        member.UpdateMember(phone, time, email, emailcheck, checkin, checkout);
        script.MsgBox(msg, Page);

        Session.Contents.RemoveAll();
        GridView2.EditIndex = -1;
        DataSet ds = member.SelectMember(phone);
        GridView2.DataSource = ds;
        GridView2.DataBind();

        MultiView1.ActiveViewIndex = 0;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = -1;
    }

    //취소버튼
    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;

        string phone = Session["phone"].ToString();
        Member member = new Member();
        member.SelectMember(phone);

        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = 0;
        MultiView3.ActiveViewIndex = -1;
    }

    //예약취소
    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string phone = GridView2.DataKeys[e.RowIndex].Value.ToString();
        string msg = "예약이 정상적으로 취소되었습니다. 입금된 금액은 6시간 이내로 입금계좌로 환불해드립니다.";

        Member member = new Member();
        Script script = new Script();
        member.DeleteMember(phone);
        script.MsgBox(msg, Page);

        Session.Contents.RemoveAll();

        MultiView1.ActiveViewIndex = 0;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = -1;
    }

    //관리자 페이징
    protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView3.PageIndex = e.NewPageIndex;
        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = 0;
    }

    //관리자 수정버튼
    protected void GridView3_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView3.EditIndex = e.NewEditIndex;

        Member member = new Member();
        DataSet ds = member.SelectMembers();
        GridView3.DataSource = ds;
        GridView3.DataBind();

        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = 0;
    }

    //관리자 예약수정
    protected void GridView3_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string phone = GridView3.DataKeys[e.RowIndex].Value.ToString();
        string name = e.NewValues["name"].ToString();
        string time = e.NewValues["time"].ToString();
        string email = e.NewValues["email"].ToString();
        string emailcheck = e.NewValues["emailcheck"].ToString();
        string room = e.NewValues["room"].ToString();
        string day = e.NewValues["day"].ToString();
        string price = e.NewValues["price"].ToString();
        string checkin = e.NewValues["checkin"].ToString();
        string checkout = e.NewValues["checkout"].ToString();
        string msg = "관리자 : 예약정보가 정상적으로 수정되었습니다.";
       
        Member member = new Member();
        Script script = new Script();
        member.UpdateMaster(phone, name, time, email, emailcheck, room, day, price, checkin, checkout);
        script.MsgBox(msg, Page);

        GridView3.EditIndex = -1;
        DataSet ds = member.SelectMembers();
        GridView3.DataSource = ds;
        GridView3.DataBind();

        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = 0;
    }

    //관리자 취소버튼
    protected void GridView3_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView3.EditIndex = -1;

        Member member = new Member();
        member.SelectMembers();

        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = 0;
    }

    //관리자 예약취소
    protected void GridView3_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string phone = GridView3.DataKeys[e.RowIndex].Value.ToString();
        string msg = "관리자 : 정상적으로 예약이 취소되었습니다.";

        Member member = new Member();
        Script script = new Script();
        member.DeleteMember(phone);
        script.MsgBox(msg, Page);

        DataSet ds = member.SelectMembers();
        GridView3.DataSource = ds;
        GridView3.DataBind();

        MultiView1.ActiveViewIndex = -1;
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = 0;
    }

</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Table runat="server" Width="100%">
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2" HorizontalAlign="Right" Width="80%">
                <asp:ImageButton ID="ImageButton1" runat="server" Width="94" ImageUrl="~/imgs/middle_1.jpg"
                    OnClick="ImageButton1_Click" />
                <asp:ImageButton ID="ImageButton2" runat="server" Width="99" ImageUrl="~/imgs/middle_2.jpg"
                    OnClick="ImageButton2_Click" />
                <asp:ImageButton ID="ImageButton3" runat="server" Width="99" ImageUrl="~/imgs/middle_3.jpg"
                    OnClick="ImageButton3_Click" />
            </asp:TableCell>
            <asp:TableCell>
                <asp:Button ID="Button1" runat="server" Text="로그아웃" OnClick="Button1_Click" Visible="False" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <br />
    <br />

    <asp:ImageButton ID="ImageButton4" runat="server" Width="150" ImageUrl="~/imgs/right_1.jpg"
        OnClick="ImageButton4_Click"/><p>
    <asp:ImageButton ID="ImageButton5" runat="server" Width="150" ImageUrl="~/imgs/right_2.jpg"             OnClick="ImageButton5_Click"/><p>
    <asp:ImageButton ID="ImageButton6" runat="server" Width="150" ImageUrl="~/imgs/right_3.jpg" OnClick="ImageButton6_Click"/><p>
    <asp:ImageButton ID="ImageButton7" runat="server" Width="150" ImageUrl="~/imgs/right_4.jpg" OnClick="ImageButton7_Click"/><p>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" Runat="Server">
    <asp:Table ID="Table1" runat="server" Width="100%">
        <asp:TableRow>
            <asp:TableCell>
                <asp:ImageButton ID="ImageButton8" runat="server" Width="100" ImageUrl="~/imgs/bottom_1.jpg"
                    OnClick="ImageButton8_Click"/>
                <p>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <asp:Label ID="Label1" runat="server" Text="INFO" Font-Size="30" ForeColor="White" /> <br />
                상호명 : 원스하우스 / 대표 : 선상원 <br />
                사업자번호 : 201507046
            </asp:TableCell><asp:TableCell>
                <asp:Label ID="Label2" runat="server" Text="CONTACTS" Font-Size="30" ForeColor="White" /> <br />
                A.경기도 부천시 경인로 590 <br/>
                T.010.9935.7482 / 02)2610.0600
            </asp:TableCell><asp:TableCell>
                <asp:Image ID="Image6" runat="server" Width="30" ImageUrl="~/imgs/instagram.jpg" />
                INSTAGRAM - 96.8_s <p>
                2019 원스하우스 All Rights Reserved.
            </asp:TableCell></asp:TableRow></asp:Table></asp:Content><asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder4" Runat="Server">

    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <!-- 메인화면 -->
        <asp:View ID="View1" runat="server">
            <asp:Image ID="Image1" runat="server" Width="100%" ImageUrl="~/imgs/main.jpg" />
        </asp:View>
        
        <!-- 예약하기(회원가입) -->
        <asp:View ID="View2" runat="server">
            <link href="css/reserve.css" rel="stylesheet" type="text/css" />
            <link href="css/font.css" rel="stylesheet" type="text/css" />
            <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
            <script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

            <div style="margin-left:50px;">
            <asp:Image ID="Image2" runat="server" Width="300" ImageUrl="~/imgs/reserve_1.jpg" />
            <hr /><hr />

            <!-- 예약자 입력정보 -->
            <div class="sans-serif">
                <asp:Table ID="Table2" runat="server">
                    <asp:TableRow Height="40">
                        <asp:TableCell Width="200">
                            <asp:Label ID="Label3" runat="server" Text="예약자 이름" Font-Size="12" />
                            <asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red" />
                        </asp:TableCell><asp:TableCell Width="700">
                            <asp:TextBox ID="TextBox1" runat="server" size="30" maxlength="50"
                                placeholder="예약자의 이름을 입력해주세요."/>
                        </asp:TableCell></asp:TableRow><asp:TableRow Height="40">
                        <asp:TableCell>
                            <asp:Label ID="Label5" runat="server" Text="휴대전화 번호" Font-Size="12" />
                            <asp:Label ID="Label6" runat="server" Text="*" ForeColor="Red" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="TextBox2" runat="server" size="30" maxlength="50"
                                placeholder="'-'없이 입력해주세요." />
                            <br />
                            <asp:Label ID="Label7" runat="server" ForeColor="Red" Font-Size="8"
                                Text="예약 관련 연락에 이용되오니 휴대폰번호를 정확하게 입력해주세요" />
                        </asp:TableCell></asp:TableRow>
                        <asp:TableRow Height="40">
                        <asp:TableCell>
                            <asp:Label ID="Label10" runat="server" Text="픽업 이용 여부" Font-Size="12" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="TextBox4" runat="server" size="30" maxlength="50"
                                placeholder="-픽업 불가능" Enabled="False" />
                        </asp:TableCell></asp:TableRow><asp:TableRow Height="40">
                        <asp:TableCell>
                            <asp:Label ID="Label11" runat="server" Text="도착예정시간" Font-Size="12" />
                        </asp:TableCell><asp:TableCell>
                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="false">
                                <asp:ListItem Value="14:00">14:00</asp:ListItem>
                                <asp:ListItem Value="15:00">15:00</asp:ListItem>
                                <asp:ListItem Value="16:00">16:00</asp:ListItem>
                                <asp:ListItem Value="17:00">17:00</asp:ListItem>
                                <asp:ListItem Value="18:00">18:00</asp:ListItem>
                                <asp:ListItem Value="19:00">19:00</asp:ListItem>
                                <asp:ListItem Value="20:00">20:00</asp:ListItem>
                                <asp:ListItem Value="21:00">21:00</asp:ListItem>
                                <asp:ListItem Value="22:00">22:00</asp:ListItem>
                                <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                <asp:ListItem Value="24:00">24:00</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <asp:Label ID="Label12" runat="server" Text="입실 14:00 이후   |  퇴실 11:00 이전"
                               Font-Size="8" />
                        </asp:TableCell></asp:TableRow><asp:TableRow Height="40">
                        <asp:TableCell>
                            <asp:Label ID="Label13" runat="server" Text="이메일" Font-Size="12" />
                            <asp:Label ID="Label14" runat="server" Text="*" ForeColor="Red" />
                        </asp:TableCell><asp:TableCell>
                            <asp:TextBox ID="TextBox5" runat="server" size="20" maxlength="50" />
                            @
                            <asp:TextBox ID="TextBox6" runat="server" size="20" maxlength="50" />
                            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True"
                                OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                                <asp:ListItem Value="">-이메일 입력-</asp:ListItem>
                                <asp:ListItem Value="9">직접입력</asp:ListItem>
                                <asp:ListItem Value="naver.com">naver.com</asp:ListItem>
                                <asp:ListItem Value="daum.net">daum.net</asp:ListItem>
                                <asp:ListItem Value="nate.com">nate.com</asp:ListItem>
                                <asp:ListItem Value="gmail.com">gmail.com</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell></asp:TableRow><asp:TableRow Height="40">
                        <asp:TableCell>
                            <asp:Label ID="Label15" runat="server" Text="이메일 수신여부" Font-Size="12" />
                        </asp:TableCell><asp:TableCell>
                            <asp:CheckBox ID="CheckBox1" runat="server" Text="동의함"  Font-Size="8" />
                            <br />
                            <asp:Label ID="Label16" runat="server" Font-Size="8"
                                Text="예약 확인안내 및 사이트에 제공하는 유익한 소식을 이메일로 받으실 수 있습니다." />
                        </asp:TableCell></asp:TableRow></asp:Table></div><br /><br /><!-- 객실 선택 --><link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"><script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script><script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script><script>
                $(function() {
                    $("#datepicker1, #datepicker2").datepicker({
                        dateFormat: 'yy.mm.dd'
                    });
                });
            </script><div class="sans-serif">
                <asp:Image ID="Image3" runat="server" Width="200" ImageUrl="~/imgs/reserve_5.jpg" />
                <hr /><hr />

                <asp:RadioButton ID="RadioButton1" runat="server" Text="나눔관 5406호" Font-Size="12"
                    GroupName="room"/>
                &nbsp;&nbsp; <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True"
                    OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
                    <asp:ListItem Value="0">-일수 선택-</asp:ListItem><asp:ListItem Value="1">1박</asp:ListItem><asp:ListItem Value="2">2박</asp:ListItem><asp:ListItem Value="3">3박</asp:ListItem></asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label17" runat="server" Text="0원" Font-Size="12" />
                <br />
                <asp:Image ID="Image4" runat="server" Width="600" ImageUrl="~/imgs/reserve_3.jpg" />
                <br /><br />

                <asp:RadioButton ID="RadioButton2" runat="server" Text="나눔관 5421호" Font-Size="12" 
                    GroupName="room"/>
                &nbsp;&nbsp; <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True"
                    OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged">
                    <asp:ListItem Value="0">-일수 선택-</asp:ListItem><asp:ListItem Value="1">1박</asp:ListItem><asp:ListItem Value="2">2박</asp:ListItem><asp:ListItem Value="3">3박</asp:ListItem></asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label18" runat="server" Text="0원" Font-Size="12" />
                <br />
                <asp:Image ID="Image5" runat="server" Width="600" ImageUrl="~/imgs/reserve_4.jpg" />
                <br />

                <asp:Table ID="Table3" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label19" runat="server" Text="Check In" Font-Size="12" />
                            <asp:Label ID="Label20" runat="server" Text="*" ForeColor="Red" />
                        </asp:TableCell><asp:TableCell>
                            <input type="text" id="datepicker1" name="checkin"
			                    placeholder="체크인 할 날짜">
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label21" runat="server" Text="Check Out" Font-Size="12" />
                            <asp:Label ID="Label22" runat="server" Text="*" ForeColor="Red" />
                        </asp:TableCell><asp:TableCell>
                            <input type="text" id="datepicker2" name="checkout"
   			                    placeholder="체크아웃 할 날짜">
                        </asp:TableCell></asp:TableRow></asp:Table></div><br /><br /><!-- 결제 수단 --><div class="sans-serif">
                <asp:Image ID="Image7" runat="server" Width="300" ImageUrl="~/imgs/reserve_2.jpg" />
                <hr /><hr />

                <asp:Table ID="Table4" runat="server">
                    <asp:TableRow Height="40">
                        <asp:TableCell ColumnSpan="2">
                            <asp:RadioButton ID="RadioButton3" runat="server" Text="무통장입금" Checked="True" Enabled="False" Font-Size="12" />
                        </asp:TableCell></asp:TableRow><asp:TableRow Height="40">
                        <asp:TableCell ColumnSpan="2">
                            <asp:Label ID="Label23" runat="server" Font-Size="8" 
                                Text="· 입금기한 : 예약 후 3시간 이내" />
                            <br />
                            <asp:Label ID="Label24" runat="server" Font-Size="8" 
                                Text="· 입금기한 내 입금확인 되지 않으면 예약이 자동 취소됩니다." />
                            <br />
                            <asp:Label ID="Label25" runat="server" Font-Size="8" 
                                Text="· 입금확인이 되면 예약완료 문자(펜션 연락처, 예약번호 등)가 휴대폰으로 전송됩니다." />
                            <br />
                            <asp:Label ID="Label26" runat="server" Font-Size="8" ForeColor="Red"
                                Text="· 무통장입금 시 반드시 예약자명으로 입금 하셔야 입금확인이 됩니다." />
                            <br />
                            <asp:Label ID="Label27" runat="server" Font-Size="8" ForeColor="Red"
                                Text="· 은행 미선택 시 자동으로 국민은행 계좌가 설정되오니 주의하시기 바랍니다." />
                        </asp:TableCell></asp:TableRow><asp:TableRow Height="40">
                        <asp:TableCell>
                            <asp:Label ID="Label28" runat="server" Text="무통장 입금" Font-Size="12" />
                            <asp:Label ID="Label29" runat="server" Text="*" ForeColor="Red" />
                        </asp:TableCell><asp:TableCell>
                            <asp:DropDownList ID="DropDownList5" runat="server">
                                <asp:ListItem Value="국민662601-04-029895">-은행 선택-</asp:ListItem>
                                <asp:ListItem Value="국민662601-04-029895">국민662601-04-029895</asp:ListItem>
                                <asp:ListItem Value="신한110-441-105498">신한110-441-105498</asp:ListItem>
                                <asp:ListItem Value="기업107-141422-14-002">기업107-141422-14-002</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell></asp:TableRow></asp:Table><div align="center">
                    <asp:Button ID="Button2" runat="server" Text="결제하기" OnClick="Button2_Click"
                        Width="100" Height="40" />
                </div>
            </div>
            </div>
        </asp:View>

        <!-- 예약확인(로그인) -->
        <asp:View ID="View3" runat="server">
            <link href="css/checkForm.css" rel="stylesheet" type="text/css" />
            <div style="margin-left:50px;">
                <div align="center">
                    <asp:Image ID="Image8" runat="server" Width="400" ImageUrl="~/imgs/check_1.jpg" />
                    <p>
                    <asp:TextBox ID="TextBox7" runat="server" placeholder="예약자의 이름을 입력해 주세요."
                        size="35" MaxLength="50"/>
                    <p>
                    <asp:TextBox ID="TextBox8" runat="server" placeholder="전화번호를 '-'없이 입력해 주세요."
                        size="35" MaxLength="50"/>
                    <p><br />
                        <asp:Button ID="Button3" runat="server" Text="조회하기" OnClick="Button3_Click" />
                </div>
            </div>
        </asp:View>

        <!-- 게시판3 -->
        <asp:View ID="View4" runat="server">
            <link href="css/board.css" rel="stylesheet" type="text/css" />
            <link href="css/a.css" rel="stylesheet" type="text/css" />
            <div style="margin-left:50px;">
                <div align="center" class="sans-serif">
                    <asp:Image ID="Image11" runat="server" Width="600" ImageUrl="~/imgs/board_1.jpg" />
                    <br />
                    <asp:GridView ID="GridView1" runat="server" PageSize="10" AllowPaging="True"
                        AutoGenerateColumns="false" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="uid" ReadOnly="true" HeaderText="번호"
                                HeaderStyle-Width="40" ItemStyle-HorizontalAlign="Center"/>
                            <asp:HyperLinkField DataNavigateUrlFields="uid" DataNavigateUrlFormatString="main.aspx?uid={0}"
                                DataTextField="subject" HeaderText="제목" HeaderStyle-Width="300" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="name" ReadOnly="true" HeaderText="글쓴이"
                                HeaderStyle-Width="70" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField DataField="reg_date" ReadOnly="true" HeaderText="날짜"
                                HeaderStyle-Width="120" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField DataField="ref" ReadOnly="true" HeaderText="조회"
                               HeaderStyle-Width="40" ItemStyle-HorizontalAlign="Center" />
                        </Columns>
                    </asp:GridView>
                </div>
                <br />
                <div align="center">
                    <asp:Button ID="Button6" runat="server" Text="글 작성" CssClass="submit" OnClick="Button6_Click"
                        Width="100" Height="40" />
                </div>
            </div>
        </asp:View>

        <!-- 게시글 등록4 -->
        <asp:View ID="View7" runat="server">
            <link href="css/board.css" rel="stylesheet" type="text/css" />
            <br />
            <div align="center">
                <asp:Image ID="Image12" runat="server" Width="300" ImageUrl="~/imgs/boardForm_1.jpg" />
                <hr />
                <hr />
                <br />
            </div>
            
            <div class="sans-serif" align="center">
                <asp:Table ID="Table5" runat="server">
                    <asp:TableRow Height="40">
                        <asp:TableCell Width="100">
                            이름
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox10" runat="server" size="30" maxlength="50" CssClass="text"
                                placeholder="이름을 입력해주세요." />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Height="40">
                        <asp:TableCell>
                            제목
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox11" runat="server" size="30" maxlength="50" CssClass="text"
                                placeholder="글 제목을 입력해주세요." />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Height="40">
                        <asp:TableCell>
                            내용
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox12" runat="server" size="30" maxlength="50" TextMode="MultiLine"
                                CssClass="text" Rows="8" Columns="50" placeholder="" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Height="40">
                        <asp:TableCell>
                            비밀번호
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox13" runat="server" size="14" maxlength="4" TextMode="Password"
                                CssClass="text" placeholder="숫자 4자리 입력" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Height="40">
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Button ID="Button4" runat="server" Text="작성완료" CssClass="submit" OnClick="Button4_Click"
                                Width="100" Height="40" />
                            &nbsp;&nbsp;
                            <asp:Button ID="Button5" runat="server" Text="취소" CssClass="reset" OnClick="Button5_Click"
                                Width="100" Height="40"/>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
        </asp:View>

        <!-- 게시글 보기5 -->
        <asp:View ID="View8" runat="server">
            <link href="css/board.css" rel="stylesheet" type="text/css" />
            <div align="center">
                <asp:Image ID="Image13" runat="server" Width="600" ImageUrl="~/imgs/board_1.jpg" />
            </div>

            <!-- 게시판으로 돌아가기버튼 -->
            <div align="center">
                <asp:Table ID="Table6" runat="server" Width="55%">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Button ID="Button7" runat="server" Text="글 목록" CssClass="submit" OnClick="Button7_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>

            <!-- 게시글 내용 -->
            <div align="center">
                <asp:Table ID="Table7" runat="server" Width="55%" Border="1">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            No.<asp:Label ID="Label31" runat="server" Text="" />
                            <asp:Label ID="Label36" runat="server" Text="" Visible="false" />
                            <asp:Label ID="Label37" runat="server" Text="" Visible="false" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Label ID="Label32" runat="server" Text="" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            등록일 : &nbsp;&nbsp; <asp:Label ID="Label33" runat="server" Text="" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            글쓴이 : &nbsp;&nbsp; <asp:Label ID="Label34" runat="server" Text="" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Height="180">
                        <asp:TableCell VerticalAlign="Top">
                            <asp:Label ID="Label35" runat="server" Text="" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <br />
            <!-- 게시글 수정버튼 / 삭제버튼 -->
            <div align="center">
                <asp:Button ID="Button8" runat="server" Text="게시글 수정" CssClass="submit" OnClick="Button8_Click"
                    Width="100" Height="40" />
                &nbsp;&nbsp;
                <asp:Button ID="Button9" runat="server" Text="게시글 삭제" CssClass="reset" OnClick="Button9_Click"
                    Width="100" Height="40" />
            </div>
        </asp:View>

        <!-- 게시글 수정 - 비밀번호 확인6 -->
        <asp:View ID="View9" runat="server">
            <link href="css/board.css" rel="stylesheet" type="text/css" />
            <div align ="center">
                <asp:TextBox ID="TextBox18" runat="server" size="30" maxlength="4" CssClass="text" TextMode="Password"
                                placeholder="게시글의 비밀번호를 입력해주세요." />
                <br />
                <br />
                <asp:Button ID="Button12" runat="server" Text="확인" OnClick="Button12_Click" CssClass="submit"
                    Width="100" Height="40" />
                &nbsp;&nbsp;
                <asp:Button ID="Button13" runat="server" Text="취소" OnClick="Button13_Click" CssClass="reset"
                    Width="100" Height="40"/>
            </div>
        </asp:View>

        <!-- 게시글 수정7 -->
        <asp:View ID="View10" runat="server">
            <link href="css/board.css" rel="stylesheet" type="text/css" />
            <div align="center">
                <asp:Image ID="Image14" runat="server" Width="300" ImageUrl="~/imgs/boardUpForm_1.jpg" />
            </div>

            <div align="center">
                <asp:Table ID="Table8" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="100">
                            이름
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox14" runat="server"  size="30" maxlength="50" CssClass="text" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            제목
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox15" runat="server"  size="30" maxlength="50" CssClass="text" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            내용
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox16" runat="server" size="30" maxlength="50" TextMode="MultiLine"
                                CssClass="text" Rows="8" Columns="50" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            비밀번호
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBox17" runat="server" size="14" maxlength="4" TextMode="Password"
                                CssClass="text" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                            <asp:Button ID="Button10" runat="server" Text="수정"  CssClass="submit" OnClick="Button10_Click"
                                Width="100" Height="40" />
                            &nbsp;&nbsp;
                            <asp:Button ID="Button11" runat="server" Text="취소" CssClass="reset" OnClick="Button11_Click"
                                Width="100" Height="40"/>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
        </asp:View>
        
        <!-- 게시글 삭제 - 비밀번호 확인8 -->
        <asp:View ID="View11" runat="server">
            <link href="css/board.css" rel="stylesheet" type="text/css" />
            <div align ="center">
                <asp:TextBox ID="TextBox19" runat="server" size="30" maxlength="4" CssClass="text" TextMode="Password"
                                placeholder="게시글의 비밀번호를 입력해주세요." />
                <br />
                <br />
                <asp:Button ID="Button14" runat="server" Text="확인" OnClick="Button14_Click" CssClass="submit"
                    Width="100" Height="40" />
                &nbsp;&nbsp;
                <asp:Button ID="Button15" runat="server" Text="취소" OnClick="Button15_Click" CssClass="reset"
                    Width="100" Height="40"/>
            </div>
        </asp:View>
        
    </asp:MultiView>

    <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="-1">
        <!-- 회원전용 멀티뷰 -->
        <!-- 회원목록(개인) -->
        <asp:View ID="View5" runat="server">
            <div style="margin-left:130px;">
                <asp:Image ID="Image9" runat="server" Width="300" ImageUrl="~/imgs/check_2.jpg" />
                <br />
                <asp:Label ID="Label30" runat="server" Text="" Font-Size="20" Font-Bold="true" />
                <br />
            </div>
            
            <div align="center">
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" PageSize="10" DataKeyNames="phone"
                    OnPageIndexChanging="GridView2_PageIndexChanging" AutoGenerateColumns="false" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating"
                    OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowDeleting="GridView2_RowDeleting">
                    <Columns>
                        <asp:CommandField ShowEditButton="true" EditText="예약수정" ShowDeleteButton="true"
                            DeleteText="예약취소" />

                        <asp:BoundField DataField="name" ReadOnly="true" HeaderText="이름"
                            ItemStyle-Width="60" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="phone" ReadOnly="true" HeaderText="전화번호" />
                        <asp:BoundField DataField="time" ReadOnly="false" HeaderText="도착시간"
                            ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="email" ReadOnly="false" HeaderText="E-Mail" />
                        <asp:BoundField DataField="emailcheck" ReadOnly="false" HeaderText="E-Mail수신"
                            ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="room" ReadOnly="true" HeaderText="객실명" />
                        <asp:BoundField DataField="day" ReadOnly="true" HeaderText="숙박 일 수"
                            ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="price" ReadOnly="true" HeaderText="입금가격" />
                        <asp:BoundField DataField="checkin" ReadOnly="false" HeaderText="CheckIn" />
                        <asp:BoundField DataField="checkout" ReadOnly="false" HeaderText="CheckOut" />
                        <asp:BoundField DataField="reg_date" ReadOnly="true" HeaderText="결제날짜" />
                    </Columns>
                </asp:GridView>
            </div>
            
        </asp:View>
    </asp:MultiView>

    <asp:MultiView ID="MultiView3" runat="server" ActiveViewIndex="-1">
        <!-- 관리자 전용목록 -->
        <asp:View ID="View6" runat="server">
            <div align="center">
                <asp:Image ID="Image10" runat="server" Width="800" ImageUrl="~/imgs/memberList_1.jpg" />
                <br />
            </div>
 
            <div align="center">
                            <asp:GridView ID="GridView3" runat="server" PageSize="5" AllowPaging="True" DataKeyNames="phone"
                OnPageIndexChanging="GridView3_PageIndexChanging" AutoGenerateColumns="false"
                OnRowEditing="GridView3_RowEditing" OnRowUpdating="GridView3_RowUpdating" 
                OnRowDeleting="GridView3_RowDeleting" OnRowCancelingEdit="GridView3_RowCancelingEdit">
                <Columns>
                    <asp:CommandField ShowEditButton="true" EditText="예약수정" ShowDeleteButton="true" DeleteText="예약취소" />

                    <asp:BoundField DataField="name" ReadOnly="false" HeaderText="이름"
                        ItemStyle-Width="60" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="phone" ReadOnly="true" HeaderText="전화번호" />
                    <asp:BoundField DataField="time" ReadOnly="false" HeaderText="도착시간"
                        ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="email" ReadOnly="false" HeaderText="E-Mail" />
                    <asp:BoundField DataField="emailcheck" ReadOnly="false" HeaderText="E-Mail수신"
                        ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="room" ReadOnly="false" HeaderText="객실명" />
                    <asp:BoundField DataField="day" ReadOnly="false" HeaderText="숙박 일 수"
                        ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="price" ReadOnly="false" HeaderText="입금가격"
                        ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="checkin" ReadOnly="false" HeaderText="CheckIn" />
                    <asp:BoundField DataField="checkout" ReadOnly="false" HeaderText="CheckOut" />
                    <asp:BoundField DataField="reg_date" ReadOnly="true" HeaderText="결제날짜" />
                    </Columns>
            </asp:GridView>
            </div>
        </asp:View>

    </asp:MultiView>
</asp:Content>