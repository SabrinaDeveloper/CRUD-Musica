<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Alterar Música</title>
    <link rel="stylesheet" href="tela1.css">
</head>
<body>
    <% 
        String nome = request.getParameter("nome");
        String artista = request.getParameter("artista");
        String duracao = request.getParameter("duracao"); // Recebendo duração como String
        int id = Integer.parseInt(request.getParameter("id"));

        Connection conecta = null;
        PreparedStatement st = null;

        try {
            // Conexão com o banco
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/app_musicas";
            String user = "root";
            String password = "";
            conecta = DriverManager.getConnection(url, user, password);

            // Query para atualizar
            String sql = "UPDATE musicas SET nome=?, artista=?, duracao=? WHERE id=?";
            st = conecta.prepareStatement(sql);
            st.setString(1, nome);
            st.setString(2, artista);
            st.setString(3, duracao); // Duração no formato 'hh:mm:ss'
            st.setInt(4, id);

            int rowsUpdated = st.executeUpdate();

            if (rowsUpdated > 0) {
                out.print("<p class='success'>Música atualizada com sucesso!</p>");
            } else {
                out.print("<p class='error'>Falha ao atualizar a música.</p>");
            }
        } catch (SQLException e) {
            out.print("<p class='error'>Erro no banco de dados: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.print("<p class='error'>Erro geral: " + e.getMessage() + "</p>");
        } finally {
            if (st != null) st.close();
            if (conecta != null) conecta.close();
        }
    %>
    <a href="listar.jsp">Voltar para a lista</a>
</body>
</html>
