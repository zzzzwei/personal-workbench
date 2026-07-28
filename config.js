// ============================================================
//  在这里填入你的 Supabase 项目信息
//  获取位置：Supabase 后台 → 左侧 Project Settings → API
//    - url      = Project URL        （形如 https://xxxx.supabase.co）
//    - anonKey  = anon / public key  （一长串以 eyJ 开头的字符串）
//
//  anon key 是“公开”的，可以放心放前端；真正保护数据的是上面的 RLS 策略
//  （每个用户只能读写自己的那一行），别人拿到 key 也看不到你的数据。
//
//  填好之前，APP 会自动退回“纯本地模式”（和升级前一模一样，数据只存在本机）。
//  填好并重新部署后，打开 APP 会要求用邮箱注册/登录，数据就同步到云端了。
// ============================================================
const SUPABASE_CONFIG = {
  url:     'https://cudrzlumftuuqnzsfuri.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN1ZHJ6bHVtZnR1dXFuenNmdXJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODUxOTE3NTAsImV4cCI6MjEwMDc2Nzc1MH0.t1-k6EunPhEWrATpad7FMfFJu9vf2QKW0pTbm3Z1kkM'
};
