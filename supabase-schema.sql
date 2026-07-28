-- 个人工作台 · Supabase 表结构
-- 用法：登录 Supabase 后台 → 左侧 SQL Editor → 新建查询 → 粘贴本文件全部内容 → Run
-- 说明：每条用户只有一行数据，整个工作台状态作为 JSON 存在 data 字段里；
--       行级安全(RLS)保证用户只能读写自己的那一行。

create table if not exists public.workbench (
  user_id   uuid primary key references auth.users(id) on delete cascade,
  data      jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.workbench enable row level security;

drop policy if exists "own row" on public.workbench;
create policy "own row" on public.workbench
  for all
  using     (auth.uid() = user_id)
  with check (auth.uid() = user_id);
