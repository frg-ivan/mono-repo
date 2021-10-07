using UnityEditor;
using UnityEngine;

namespace FRG.Core
{
    [CustomEditor(typeof(DummyOne))]
    public class DummyOneEditor : UnityEditor.Editor
    {
        static readonly GUIContent content = new GUIContent("Dummy One");

        public override void OnInspectorGUI()
        {
            if (GUILayout.Button(content, EditorStyles.miniButton))
            {
                //nothing
            }

            DrawDefaultInspector();
        }
    }
}