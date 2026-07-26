-- ÍRIS · Óptica de Autor
-- Catálogo de armações (leitura pública) + pedidos capturados no checkout
-- (gravação pública, sem leitura pública). Rode este arquivo no
-- SQL Editor do seu projeto Supabase (Dashboard → SQL Editor → New query).

create table if not exists public.armacoes (
  id text primary key,
  nome text not null,
  casa text not null,
  shape text not null,
  cat text not null,
  preco numeric(10,2) not null,
  preco_antigo numeric(10,2) not null default 0,
  rating numeric(2,1) not null default 0,
  cores jsonb not null default '[]'::jsonb,
  tag text not null default '',
  mm text not null default '',
  mat text not null default '',
  descricao text not null default '',
  ordem int not null default 0,
  ativo boolean not null default true,
  criado_em timestamptz not null default now()
);

alter table public.armacoes enable row level security;

drop policy if exists "armacoes_select_publica" on public.armacoes;
create policy "armacoes_select_publica"
  on public.armacoes for select
  to anon, authenticated
  using (ativo = true);

create table if not exists public.pedidos (
  id uuid primary key default gen_random_uuid(),
  criado_em timestamptz not null default now(),
  itens jsonb not null,
  total numeric(10,2) not null,
  frete_gratis boolean not null default false,
  canal text not null default 'whatsapp',
  status text not null default 'novo'
);

alter table public.pedidos enable row level security;

drop policy if exists "pedidos_insert_publico" on public.pedidos;
create policy "pedidos_insert_publico"
  on public.pedidos for insert
  to anon, authenticated
  with check (true);
-- Nenhuma policy de select/update/delete é criada para anon/authenticated:
-- por padrão o RLS já bloqueia essas operações. Leia os pedidos pelo
-- Dashboard (que usa a service role e ignora RLS) ou com uma policy à parte
-- restrita a um usuário autenticado da loja, se/quando houver login de admin.

-- Semeadura: catálogo atual do site, pra a tabela já nascer preenchida.
insert into public.armacoes (id,nome,casa,shape,cat,preco,preco_antigo,rating,cores,tag,mm,mat,descricao,ordem) values
('ir01','Meridiano','Íris Signature','retangular','masculino',289,389,4.8,'["#14121F","#4A2E1C","#2C3E63"]','Mais vendido','52▫18▫145','Acetato italiano','Retangular de linha reta e peso pluma. Estrutura em acetato italiano prensado, com hastes flexíveis. Equilibra rostos redondos e ovais.',1),
('ir02','Aurora','Íris Femme','gatinho','feminino',319,0,4.9,'["#6B1F3A","#14121F","#B8935A"]','Novo','50▫17▫140','Acetato perolado','Cat-eye de curva ascendente. Levanta o olhar e alonga rostos quadrados sem pesar no visual.',2),
('ir03','Zênite','Íris Metal','aviador','unissex',349,0,4.7,'["#B8935A","#9AA3B0","#14121F"]','','56▫15▫142','Metal escovado','Aviador de ponte dupla em metal escovado. O desenho que atravessou seis décadas sem envelhecer.',3),
('ir04','Órbita','Íris Vintage','redonda','unissex',259,329,4.6,'["#14121F","#4A2E1C","#8A5A3C"]','Promoção','47▫21▫145','Metal fino','Redonda de aro fino e ponte de chave. Suaviza traços angulares e carrega um ar deliberadamente intelectual.',4),
('ir05','Basalto','Íris Statement','quadrada','masculino',379,0,4.8,'["#14121F","#2C3E63","#1F3D35"]','','55▫18▫148','Acetato fosco','Quadrada oversized com pegada arquitetônica. Volume calculado para quem quer presença sem ruído.',5),
('ir06','Prisma','Íris Modern','hexagonal','feminino',299,0,4.7,'["#B8935A","#6B1F3A","#9AA3B0"]','Novo','51▫19▫143','Metal leve','Geometria hexagonal em fio de metal. Moderno de perto, discreto de longe — dois óculos num só.',6),
('ir07','Base','Íris Essentials','retangular','unissex',199,0,4.5,'["#14121F","#9AA3B0","#2C3E63"]','Entrada','53▫17▫142','Polímero TR-90','O par de todo dia. TR-90 resistente a impacto, quase indestrutível e leve o bastante pra esquecer no rosto.',7),
('ir08','Marlene','Íris Femme','gatinho','feminino',339,429,4.9,'["#14121F","#6B1F3A","#C9C2E0"]','Promoção','52▫16▫140','Acetato bicolor','Cat-eye pronunciado com acabamento em duas camadas de acetato. Feito pra ser notado de frente e de perfil.',8),
('ir09','Halo','Íris Metal','redonda','unissex',279,0,4.6,'["#9AA3B0","#B8935A","#14121F"]','','48▫20▫145','Aço cirúrgico','Redonda em aço cirúrgico com solda invisível. Aro contínuo, sem emenda aparente em nenhum ângulo.',9),
('ir10','Titan','Íris Metal','aviador','masculino',399,0,4.8,'["#14121F","#9AA3B0","#B8935A"]','Premium','57▫16▫145','Titânio β','Titânio beta: 9 g no rosto, hipoalergênico e com memória de forma. Para quem usa óculos catorze horas por dia.',10),
('ir11','Cubo','Íris Statement','quadrada','unissex',289,0,4.5,'["#4A2E1C","#14121F","#1F3D35"]','','54▫17▫145','Acetato mate','Quadrada de proporção contida. Atravessa a semana inteira: reunião de manhã, bar à noite.',11),
('ir12','Vértice','Íris Modern','hexagonal','masculino',329,399,4.7,'["#14121F","#9AA3B0","#2C3E63"]','Promoção','53▫18▫146','Metal flat','Hexagonal com haste chata e dobradiça flex. Ângulo marcado que foge do formato óbvio.',12)
on conflict (id) do update set
  nome=excluded.nome, casa=excluded.casa, shape=excluded.shape, cat=excluded.cat,
  preco=excluded.preco, preco_antigo=excluded.preco_antigo, rating=excluded.rating,
  cores=excluded.cores, tag=excluded.tag, mm=excluded.mm, mat=excluded.mat,
  descricao=excluded.descricao, ordem=excluded.ordem;
