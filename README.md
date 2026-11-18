# Local Running Routes: setup guide

You will create three free accounts (GitHub, Supabase, Netlify) and copy two values between them. Budget about 30 minutes. Free-tier terms change, so glance at each service's pricing page when you sign up.

## 1. Supabase (the shared database and sign-in)
1. Go to supabase.com, sign up, click **New project**. Name it `running-routes`, choose a database password (save it somewhere), pick the region nearest you, and create it. Wait a minute or two for it to finish.
2. In the left menu open **SQL Editor** > **New query**. Open `schema.sql` from this folder, copy everything, paste it in, and press **Run**. You should see "Success".
3. Open **Project Settings** > **API** (or **API Keys**). Keep this tab open. You need two values:
   - **Project URL** (looks like `https://abcd1234.supabase.co`)
   - The **anon / public** key (newer dashboards call it the **publishable** key). Never use the "service_role" or "secret" key.

## 2. Fill in config.js
Open `config.js` in any text editor and paste in the URL and key between the quotes. Set `TOWN_HINT` to your town, e.g. `"Springfield, Ohio"`, so address searches favor it. Set `DEFAULT_CENTER` to your town's latitude and longitude if you like (right-click your town in Google Maps to copy them).

## 3. GitHub (stores the files, lets Claude Code edit them)
1. Sign up at github.com. Click **New repository**, name it `running-routes`, keep it Public, and create it.
2. Click **uploading an existing file**, drag in `index.html` and `config.js` (and `schema.sql` and `README.md` if you want them kept), and click **Commit changes**.

## 4. Netlify (puts it on the web)
1. Sign up at netlify.com using **Sign up with GitHub**.
2. **Add new site** > **Import an existing project** > GitHub > choose `running-routes`. Leave build command and publish directory empty. Click **Deploy**.
3. When it finishes you get an address like `https://something.netlify.app`. Under **Site configuration** > **Change site name** you can pick a nicer one.

## 5. Tell Supabase your website address
In Supabase, go to **Authentication** > **URL Configuration**. Set **Site URL** to your Netlify address and also add it under **Redirect URLs**. Save. Without this, the emailed sign-in links won't bring people back to your site.

## 6. Test it
Open your site. Sign in with your email (a link arrives; click it). Add a GPX file, open the route, download it, then delete it. Try an address under **My point** and the N/E/S/W filters.

## 7. Invite friends
Send them your Netlify link. Anyone can browse. To add routes they sign in with their email. Export GPX files from Strava, Garmin Connect, Apple Fitness apps, or a route planner.

Notes:
- Supabase's built-in email sender allows only a few sign-in emails per hour. That is fine for a handful of friends. If it becomes a problem, set up a custom email sender in Supabase under Authentication > SMTP Settings.
- To remove someone's route: Supabase **Table Editor** > `routes`, delete the row.
- Address search uses the free OpenStreetMap Nominatim service, which asks for light use. Map tiles come from OpenStreetMap too.

## 8. Keep editing with Claude
Install Claude Code (see claude.com/claude-code), then in a terminal: `git clone https://github.com/YOUR-NAME/running-routes`, `cd running-routes`, `claude`, and ask for changes. When changes are pushed to GitHub, Netlify redeploys automatically.
