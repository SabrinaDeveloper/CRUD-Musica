<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar</title>
</head>
<body>
<%
    // Inicializa as variáveis
    String nome_musica;
    String nome_artista;
    String duracao;

    // Recebe os dados do formulário
    nome_musica = request.getParameter("nome_musicas");
    nome_artista = request.getParameter("nome_artista");
    duracao = request.getParameter("duracao");
 
            // Conexão com o banco de dados
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/app_musicas";
            String user = "root";
            String password = "";
            conecta = DriverManager.getConnection(url, user, password);

            // Atualiza os dados na tabela
            String sql = "SELECT * FROM musicas WHERE nome_musica=?";
            st = conecta.prepareStatement(sql);
            st.setString(2,nome_musica);
            st.setString(3, nome_artista);
            st.setString(4, duracao);
            st.executeUpdate();

            out.print("Os dados da foram editados com sucesso."); 

%>


       
</body>
</html>