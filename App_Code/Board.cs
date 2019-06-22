using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Board의 요약 설명입니다.
/// </summary>
public class Board
{
    string _constring;

    //게시판
    public int uid;
    public string name;
    public string password;
    public string subject;
    public string comment;
    public string reg_date;
    public int ref1;

    public Board()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
        _constring = System.Configuration.ConfigurationManager.ConnectionStrings["MyAspDB"].ConnectionString;
    }

    //전체적인 게시글 목록보기
    public DataSet SelectBoards()
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Select * From board Order By uid DESC";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataAdapter ad = new SqlDataAdapter();
        ad.SelectCommand = cmd;

        DataSet ds = new DataSet();
        ad.Fill(ds);

        return ds;
    }

    //게시글 보기
    public void SelectBoard(string uid)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Select * From board Where uid=@Uid";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@Uid", uid);

        con.Open();
        var rd = cmd.ExecuteReader();
        if (rd.Read())
        {
            this.uid = int.Parse(rd["uid"].ToString());
            this.name = rd["name"].ToString();
            this.password = rd["password"].ToString();
            this.subject = rd["subject"].ToString();
            this.comment = rd["comment"].ToString();
            this.reg_date = rd["reg_date"].ToString();
            this.ref1 = int.Parse(rd["ref"].ToString());
        }
        rd.Close();
        con.Close();
    }

    //게시글 등록
    public void InsertBoard(string name, string password, string subject, string comment, string register,
        int ref1)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Insert Into board(name,password,subject,comment,reg_date,ref)" +
            "Values(@Name, @Password, @Subject, @Comment, @Reg_date, @Ref)";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@Name", name);
        cmd.Parameters.AddWithValue("@Password", password);
        cmd.Parameters.AddWithValue("@Subject", subject);
        cmd.Parameters.AddWithValue("@Comment", comment);
        cmd.Parameters.AddWithValue("@Reg_date", register);
        cmd.Parameters.AddWithValue("@Ref", ref1);

        con.Open();
        cmd.ExecuteNonQuery();
        
        con.Close();
    }

    //조회수 증가
    public void UpdateRef(int uid, int ref1)
    {
        ref1 = ref1 + 1;
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Update board Set ref=@Ref Where uid=@Uid";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@Ref", ref1);
        cmd.Parameters.AddWithValue("@Uid", uid);

        con.Open();
        cmd.ExecuteNonQuery();

        cmd.Clone();
        con.Close();
    }

    //게시글을 수정할 경우 비밀번호가 맞는지 판단여부
    public Boolean UpdateBoardFlag(int uid, string password)
    {
        Boolean flag = false;
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Select password From board Where uid=@Uid";
        var cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@Uid", uid);

        var rd = cmd.ExecuteReader();
        if (rd.HasRows)
        {
            if (rd.Read())
            {
                if (rd["password"].ToString().Equals(password))
                {
                    flag = true;
                }
            }
        }
        cmd.Clone();
        con.Close();

        return flag;
    }

    public void UpdateBoard(int uid, string password, string subject, string comment, string register, int ref1)
    {
        ref1 = ref1 + 1;
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Update board Set " +
            "password=@Password, subject=@Subject, comment=@Comment, reg_date=@Reg_date, ref=@Ref Where uid=@Uid";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@Password", password);
        cmd.Parameters.AddWithValue("@Subject", subject);
        cmd.Parameters.AddWithValue("@Comment", comment);
        cmd.Parameters.AddWithValue("@Reg_date", register);
        cmd.Parameters.AddWithValue("@Ref", ref1);
        cmd.Parameters.AddWithValue("@Uid", uid);

        con.Open();
        cmd.ExecuteNonQuery();

        cmd.Clone();
        con.Close();
    }

    public void DeleteBoard(int uid)
    {
        SqlConnection con = new SqlConnection(_constring);

        string sql = "Delete From board Where uid=@Uid";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@Uid", uid);

        con.Open();
        cmd.ExecuteNonQuery();

        cmd.Clone();
        con.Close();
    }
}