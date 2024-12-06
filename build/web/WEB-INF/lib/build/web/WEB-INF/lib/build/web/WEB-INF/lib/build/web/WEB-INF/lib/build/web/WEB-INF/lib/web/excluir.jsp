<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exclusão</title>
    </head>
    <body>
        <%
            //recebe o codigo digitado no formulario
            int id;
            id=Integer.parseInt(request.getParameter("id"));
            try{
                ///conecta ao banco de dados chamado bancojsp_b
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/app_musicas";
                String user="root";
                String password="";
                conecta=DriverManager.getConnection(url,user,password);
                //excluindo o produto de codigo informado   
                String sql=("DELETE FROM musicas WHERE id=?");
                st=conecta.prepareStatement(sql);
                st.setInt(1,id);
                int resultado = st.executeUpdate();//executa o DELETE
                //Verifica se sua musica foi ou nao excluido
                if (resultado == 0){
                out.print("Esta musica não está cadastrado");
            }else{
                out.print("A Música do id = " + id + " , foi excluído com sucesso");
            }
            } catch (Exception erro) {
                 String mensagemErro = erro.getMessage();
                 out.print ("<p style='color:blue;font-size:25px'>Entre em contato com o suporte '+ mensagemErro </p>");
            }
            %>
    </body>
</html>