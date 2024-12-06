<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Música</title>
        <link href="tela1.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            int id = Integer.parseInt(request.getParameter("id")); // Recebe o ID
            Connection conecta = null;
            PreparedStatement st = null;
            ResultSet resultado = null;

            try {
                // Conexão com o banco
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/app_musicas";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                // Consulta para buscar a música pelo ID
                String sql = "SELECT * FROM musicas WHERE id = ?";
                st = conecta.prepareStatement(sql);
                st.setInt(1, id);
                resultado = st.executeQuery();

                // Verifica se encontrou o registro
                if (!resultado.next()) {
                    out.print("<p class='error'>Música não encontrada.</p>");
                } else {
        %>
        <div class="campo_editar">
            <form action="editar_musica.jsp" method="post">
                <input type="hidden" name="id" value="<%= id %>" />
                <p>
                    <label for="nome">Nome da Música:</label>
                    <input type="text" name="nome" id="nome" value="<%= resultado.getString("nome") %>" required>
                </p>
                <p>
                    <label for="artista">Nome do Artista:</label>
                    <input type="text" name="artista" id="artista" value="<%= resultado.getString("artista") %>" required>
                </p>
                <p>
                    <label for="duracao">Duração:</label>
                    <input type="time" name="duracao" id="duracao" 
                           value="<%= resultado.getTime("duracao").toLocalTime().toString() %>" step="1" required>
                </p>
                <p>
                    <button class="botao_editar" type="submit">Salvar Alteração</button>
                </p>
            </form>
        </div>
        <%
                }
            } catch (Exception e) {
                out.print("<p class='error'>Erro: " + e.getMessage() + "</p>");
            } finally {
                if (resultado != null) resultado.close();
                if (st != null) st.close();
                if (conecta != null) conecta.close();
            }
        %>
    </body>
</html>
