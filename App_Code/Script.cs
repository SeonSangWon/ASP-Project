using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Script의 요약 설명입니다.
/// </summary>
public class Script
{
    public Script()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }

    public void MsgBox(String msg, Page page)
    {
        page.ClientScript.RegisterStartupScript(page.GetType(), "MessageBox",
            "alert(\"" + msg.Replace(@"\", @"\\") + "\");", true);
    }
}