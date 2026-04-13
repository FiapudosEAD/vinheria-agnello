package com.agnello.model;

public class Vinho {
    private int id;
    private String nome;
    private String uva;
    private String regiao;
    private String tipo;
    private double preco;
    private String descricao;
    private String teorAlcoolico;
    private String safra;
    private String envelhecimento;
    private String tempServico;
    private String harmonizacao;
    private int avaliacao;
    private String badge;
    private boolean ativo;

    public Vinho() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getUva() { return uva; }
    public void setUva(String uva) { this.uva = uva; }

    public String getRegiao() { return regiao; }
    public void setRegiao(String regiao) { this.regiao = regiao; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public double getPreco() { return preco; }
    public void setPreco(double preco) { this.preco = preco; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public String getTeorAlcoolico() { return teorAlcoolico; }
    public void setTeorAlcoolico(String teorAlcoolico) { this.teorAlcoolico = teorAlcoolico; }

    public String getSafra() { return safra; }
    public void setSafra(String safra) { this.safra = safra; }

    public String getEnvelhecimento() { return envelhecimento; }
    public void setEnvelhecimento(String envelhecimento) { this.envelhecimento = envelhecimento; }

    public String getTempServico() { return tempServico; }
    public void setTempServico(String tempServico) { this.tempServico = tempServico; }

    public String getHarmonizacao() { return harmonizacao; }
    public void setHarmonizacao(String harmonizacao) { this.harmonizacao = harmonizacao; }

    public int getAvaliacao() { return avaliacao; }
    public void setAvaliacao(int avaliacao) { this.avaliacao = avaliacao; }

    public String getBadge() { return badge; }
    public void setBadge(String badge) { this.badge = badge; }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; }
}
