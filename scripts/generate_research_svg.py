"""
Generate an SVG mind map for the UAV swarm research plan.
The script is self contained and uses only the Python standard library.
"""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


@dataclass
class Node:
    key: str
    label: str
    x: int
    y: int
    width: int = 260
    height: int = 90
    fill: str = "#e8f2ff"
    border: str = "#2b6cb0"


NODES: dict[str, Node] = {
    "core": Node("core", "语义驱动的\n无人机集群研究框架", 450, 40, width=320, height=100, fill="#ebf8ff"),
    "semantic": Node("semantic", "语义驱动的具身\n任务建模", 120, 190),
    "memory": Node("memory", "记忆增强的长时序\n分层决策", 450, 190),
    "distributed": Node("distributed", "异构集群的分布式\n协同决策", 780, 190),
    "semantic_layers": Node("semantic_layers", "场景-行为原子-\n控制指令统一建模", 120, 340, width=260, height=80, fill="#fdf6b2", border="#b7791f"),
    "semantic_alignment": Node("semantic_alignment", "语义-状态对齐\n与情境校验", 120, 450, width=240, height=70, fill="#fdf6b2", border="#b7791f"),
    "semantic_library": Node("semantic_library", "可组合行为原子库\n支持群体协同", 120, 560, width=240, height=70, fill="#fdf6b2", border="#b7791f"),
    "memory_hierarchy": Node("memory_hierarchy", "多时间尺度分层\n（阶段/步/周期）", 450, 340, width=260, height=80, fill="#c6f6d5", border="#2f855a"),
    "memory_short_long": Node("memory_short_long", "短期记忆 + 长期\n知识库融合", 450, 450, width=240, height=70, fill="#c6f6d5", border="#2f855a"),
    "memory_refresh": Node("memory_refresh", "策略自蒸馏与\n事件触发刷新", 450, 560, width=220, height=70, fill="#c6f6d5", border="#2f855a"),
    "dist_model": Node("dist_model", "异构能力建模与\n任务分工", 780, 340, width=240, height=80, fill="#ffe4e6", border="#c53030"),
    "dist_protocol": Node("dist_protocol", "局部通信协议与\n分布式决策", 780, 450, width=240, height=70, fill="#ffe4e6", border="#c53030"),
    "dist_allocation": Node("dist_allocation", "自适应任务分配\n兼顾公平效率", 780, 560, width=240, height=70, fill="#ffe4e6", border="#c53030"),
}

EDGES: list[tuple[str, str]] = [
    ("core", "semantic"),
    ("core", "memory"),
    ("core", "distributed"),
    ("semantic", "semantic_layers"),
    ("semantic", "semantic_alignment"),
    ("semantic", "semantic_library"),
    ("memory", "memory_hierarchy"),
    ("memory", "memory_short_long"),
    ("memory", "memory_refresh"),
    ("distributed", "dist_model"),
    ("distributed", "dist_protocol"),
    ("distributed", "dist_allocation"),
]


def svg_text_lines(label: str) -> Iterable[str]:
    # Split label on newlines to allow multi-line rendering.
    for line in label.split("\n"):
        yield line


def rect_svg(node: Node) -> str:
    text_lines = list(svg_text_lines(node.label))
    text_x = node.x + node.width / 2
    text_y = node.y + node.height / 2 - (len(text_lines) - 1) * 10
    tspans = "".join(
        f'<tspan x="{text_x}" dy="1.2em" font-weight="600">{line}</tspan>'
        for line in text_lines
    )
    return (
        f'<rect x="{node.x}" y="{node.y}" rx="12" ry="12" width="{node.width}" height="{node.height}" '
        f'fill="{node.fill}" stroke="{node.border}" stroke-width="2" />\n'
        f'<text x="{text_x}" y="{text_y}" text-anchor="middle" fill="#1a202c" '
        f'font-family="\"Noto Sans\", \"Microsoft YaHei\", sans-serif" font-size="16">{tspans}</text>'
    )


def edge_svg(source: Node, target: Node) -> str:
    x1 = source.x + source.width / 2
    y1 = source.y + source.height
    x2 = target.x + target.width / 2
    y2 = target.y
    control_y = (y1 + y2) / 2 - 10
    return (
        f'<path d="M {x1} {y1} C {x1} {control_y}, {x2} {control_y}, {x2} {y2}" '
        f'stroke="#4a5568" stroke-width="2" fill="none" marker-end="url(#arrow)" />'
    )


def build_svg() -> str:
    width, height = 1100, 700
    rects = "\n".join(rect_svg(node) for node in NODES.values())
    edges = "\n".join(edge_svg(NODES[s], NODES[t]) for s, t in EDGES)
    return f"""
<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">
  <defs>
    <marker id="arrow" markerWidth="10" markerHeight="10" refX="6" refY="3" orient="auto" markerUnits="strokeWidth">
      <path d="M0,0 L0,6 L9,3 z" fill="#4a5568" />
    </marker>
  </defs>
  <rect x="0" y="0" width="{width}" height="{height}" fill="white" />
  {edges}
  {rects}
</svg>
""".strip()


def main() -> None:
    svg_content = build_svg()
    output_path = Path(__file__).resolve().parent.parent / "research_architecture.svg"
    output_path.write_text(svg_content, encoding="utf-8")
    print(f"SVG saved to {output_path}")


if __name__ == "__main__":
    main()
