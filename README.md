# Vinheria Agnello — Sprint 2
## Projeto de Transformação Digital | FIAP - Engenharia de Software

---

## Estrutura do Projeto

```
vinheria-agnello/
├── webapp/                          <- Arquivos Web (deploy no Tomcat)
│   ├── css/
│   │   └── style.css               <- CSS completo (Sprint 1 + novas telas)
│   ├── js/
│   │   └── script.js               <- JavaScript (catálogo, carrinho, filtros)
│   ├── WEB-INF/
│   │   ├── web.xml                 <- Configuração do Servlet Container
│   │   └── lib/                    <- JARs (H2, JSTL) — você precisa adicionar
│   ├── index.jsp                   <- Homepage
│   ├── login.jsp                   <- Tela de login
│   ├── cadastro.jsp                <- Tela de cadastro
│   ├── catalogo.jsp                <- Catálogo de vinhos
│   ├── produto.jsp                 <- Detalhe do produto
│   ├── carrinho.jsp                <- Página do carrinho
│   └── logout.jsp                  <- Logout (invalida sessão)
├── src/
│   └── com/agnello/
│       ├── model/
│       │   └── Usuario.java        <- Modelo de dados do usuário
│       ├── dao/
│       │   └── UsuarioDAO.java     <- Acesso ao banco de dados (CRUD)
│       ├── servlet/
│       │   ├── LoginServlet.java   <- Processa login
│       │   └── CadastroServlet.java<- Processa cadastro
│       └── util/
│           └── ConnectionFactory.java <- Fábrica de conexões JDBC
├── sql/
│   └── schema.sql                  <- Script de criação das tabelas + dados
├── libs/                           <- Coloque os JARs baixados aqui
├── deploy.bat                      <- Script de deploy (Windows)
├── deploy.sh                       <- Script de deploy (Mac/Linux)
└── README.md                       <- Este arquivo
```

---

## CONFIGURAÇÃO DO AMBIENTE (Passo a Passo)

### Passo 1 — Instalar o JDK 17

**Windows:**
1. Acesse: https://adoptium.net/
2. Baixe o Temurin JDK 17 (ou superior) para Windows
3. Execute o instalador — MARQUE a opção "Set JAVA_HOME variable"
4. Para verificar, abra o CMD e digite:
   ```
   java -version
   javac -version
   ```

**Mac:**
```bash
brew install openjdk@17
```

---

### Passo 2 — Instalar o Apache Tomcat 10

1. Acesse: https://tomcat.apache.org/download-10.cgi
2. Na seção "Binary Distributions > Core", baixe:
   - Windows: 64-bit Windows zip
   - Mac/Linux: tar.gz
3. Extraia em uma pasta fácil de encontrar:
   - Windows: C:\tomcat10
   - Mac: ~/tomcat10
4. Teste se funciona:
   - Windows: abra o CMD e execute C:\tomcat10\bin\startup.bat
   - Mac: ~/tomcat10/bin/startup.sh
5. Abra http://localhost:8080 no navegador
   - Se aparecer a página do Tomcat, está funcionando!

---

### Passo 3 — Baixar as Bibliotecas (JARs)

Crie uma pasta "libs" na raiz do projeto e baixe:

1. H2 Database (banco local para testes):
   https://repo1.maven.org/maven2/com/h2database/h2/2.2.224/h2-2.2.224.jar

2. JSTL 2.0 (Tags JSP compatíveis com Tomcat 10):
   - API: https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/2.0.0/jakarta.servlet.jsp.jstl-api-2.0.0.jar
   - IMPL: https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/2.0.0/jakarta.servlet.jsp.jstl-2.0.0.jar

3. Servlet API: já vem dentro do Tomcat em TOMCAT/lib/servlet-api.jar

---

### Passo 4A — IntelliJ IDEA Community (RECOMENDADO)

A versão Community não tem botão "Run on Server", mas funciona perfeitamente
fazendo o deploy manual. É assim que muitos devs profissionais trabalham.

**Criando o projeto:**

1. Abra o IntelliJ -> New Project
2. Escolha "Java" no menu da esquerda
3. JDK: selecione o JDK 17
4. NÃO selecione nenhum framework
5. Clique Next -> dê o nome "vinheria-agnello" -> Finish

**Copiando os arquivos do ZIP:**

6. Abra a pasta do projeto no Explorer/Finder
7. Copie a pasta src/com/ do ZIP para dentro de src/ do projeto IntelliJ
8. Copie a pasta webapp/ do ZIP para a RAIZ do projeto
9. Copie a pasta sql/ do ZIP para a RAIZ do projeto
10. Copie a pasta libs/ (com os JARs) para a RAIZ do projeto

**Configurando as dependências:**

11. File -> Project Structure (Ctrl+Alt+Shift+S)
12. No menu esquerdo, clique em "Modules"
13. Aba "Dependencies" -> clique no "+" -> "JARs or Directories"
14. Adicione TODOS estes JARs:
    - libs/h2-2.2.224.jar
    - libs/jakarta.servlet.jsp.jstl-api-2.0.0.jar
    - libs/jakarta.servlet.jsp.jstl-2.0.0.jar
    - C:\tomcat10\lib\servlet-api.jar  (IMPORTANTE para compilar Servlets!)
15. Clique Apply -> OK

**Compilando:**

16. Build -> Build Project (Ctrl+F9)
17. Se não der erro, os .class ficam em out/production/vinheria-agnello/

**Deploy no Tomcat (use o script ou faça manualmente):**

18. Execute o deploy.bat (Windows) ou deploy.sh (Mac)
    OU faça manualmente:
    - Copie webapp/ para TOMCAT/webapps/vinheria-agnello/
    - Copie out/production/vinheria-agnello/com/ para 
      TOMCAT/webapps/vinheria-agnello/WEB-INF/classes/com/
    - Copie os JARs (h2, jstl) para 
      TOMCAT/webapps/vinheria-agnello/WEB-INF/lib/

**Executando:**

19. Inicie o Tomcat: C:\tomcat10\bin\startup.bat
20. Acesse: http://localhost:8080/vinheria-agnello/
21. Para parar: C:\tomcat10\bin\shutdown.bat

---

### Passo 4B — VS Code (Alternativa)

**Extensões necessárias (instale todas):**
- Extension Pack for Java (Microsoft)
- Community Server Connectors (Red Hat)

**Configurando:**

1. Abra o VS Code
2. File -> Open Folder -> pasta vinheria-agnello do ZIP
3. Crie/edite .vscode/settings.json:
```json
{
  "java.project.referencedLibraries": [
    "libs/**/*.jar",
    "C:/tomcat10/lib/servlet-api.jar"
  ],
  "java.project.sourcePaths": ["src"],
  "java.project.outputPath": "out"
}
```
4. O VS Code compila automaticamente ao salvar
5. Use o mesmo deploy.bat/deploy.sh para copiar ao Tomcat

---

## Integração com Cloud (Oracle Cloud Free Tier)

### Como configurar:

1. Crie conta em https://cloud.oracle.com (Free Tier, grátis)

2. Crie um Autonomous Database:
   - Menu > Oracle Database > Autonomous Transaction Processing
   - Nome: agnellodb | Always Free
   - Defina a senha do ADMIN

3. Baixe o Wallet (Database Connection > Download Wallet)

4. Edite ConnectionFactory.java — descomente OPÇÃO 1 (Oracle):
   ```java
   private static final String URL = 
     "jdbc:oracle:thin:@agnellodb_high?TNS_ADMIN=/caminho/wallet";
   private static final String USER = "ADMIN";
   private static final String PASSWORD = "SuaSenha123";
   ```

5. Adicione ojdbc11.jar na pasta libs/ e WEB-INF/lib/

6. Execute sql/schema.sql no SQL Worksheet do Oracle Cloud

---

## Tecnologias Utilizadas

- Frontend: HTML5, CSS3, JavaScript (ES6)
- Backend: Java 17, JSP, Servlets
- Banco de Dados: H2 (local) / Oracle ATP (cloud)
- Servidor: Apache Tomcat 10
- Cloud: Oracle Cloud Infrastructure (Free Tier)
- Padrão de Projeto: MVC (Model-View-Controller)

---

## Arquitetura MVC

```
[Navegador] -> (request) -> [Servlet (Controller)]
                                   |
                            [DAO (Model)] -> [Banco de Dados]
                                   |
                            [JSP (View)] -> (response) -> [Navegador]
```

- Model: Usuario.java — representa os dados
- View: Arquivos .jsp — interface visual
- Controller: LoginServlet, CadastroServlet — lógica de negócio
- DAO: UsuarioDAO.java — acesso ao banco de dados
- Util: ConnectionFactory.java — gerencia conexões JDBC
