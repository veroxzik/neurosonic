﻿using theori.IO;
using theori.Resources;
using theori.Scripting;

namespace NeuroSonic.ChartSelect
{
    public class ChartSelectLayer : NscLayer
    {
        private readonly ClientResourceLocator m_locator;
        private readonly ClientResourceManager m_resources;

        private readonly LuaScript m_script;

        public ChartSelectLayer(ClientResourceLocator locator)
        {
            m_locator = locator;
            m_resources = new ClientResourceManager(locator);

            m_script = new LuaScript();
        }

        public override bool AsyncLoad()
        {
            // NOTE(local): Separate database files for different things?
            // Not entirely sure if multiple databases matters for standalone, or at all for that matter,
            //  since we plan to have online chart repos be streamed and scores uploaded rather than stored locally.
            // So only local charts would -need- a database? And extra databases would be caches for the
            //  repos you play with? So that's a reason for multiple dbs?

            m_script.LoadFile(m_locator.OpenFileStream("scripts/generic-layer.lua"));
            m_script.LoadFile(m_locator.OpenFileStream("scripts/chart_select/main.lua"));
            m_script.InitResourceLoading(m_locator);

            if (!m_script.LuaAsyncLoad())
                return false;

            return true;
        }

        public override bool AsyncFinalize()
        {
            if (!m_script.LuaAsyncFinalize())
                return false;
            m_script.InitSpriteRenderer(m_locator);

            return true;
        }

        public override void Initialize()
        {
            base.Initialize();

            m_script.CallIfExists("Init");
        }

        public override void Destroy()
        {
            base.Destroy();

            m_script.Dispose();
            m_resources.Dispose();
        }

        public override void Update(float delta, float total)
        {
            base.Update(delta, total);

            m_script.Update(delta, total);
        }

        public override void Render()
        {
            m_script.Draw();
        }

        public override bool KeyPressed(KeyInfo info)
        {
            switch (info.KeyCode)
            {
                case KeyCode.ESCAPE: Pop(); break;

                default: return false;
            }

            return true;
        }

        public override bool ControllerButtonPressed(ControllerInput input)
        {
            switch (input)
            {
                case ControllerInput.Back: Pop(); break;

                default: return false;
            }

            return true;
        }

    }
}
