"""
使用标准库生成策略决策层框架图（SVG）。
"""
from __future__ import annotations

import os
from dataclasses import dataclass
from html import escape
from typing import Iterable


@dataclass
class Box:
    x: int
    y: int
    width: int
    height: int
    text: str
    fill: str


@dataclass
class Arrow:
    start: tuple[int, int]
    end: tuple[int, int]
    text: str | None = None
    curved: bool = False
    curve_offset: tuple[int, int] | None = None


SVG_HEADER = """<svg xmlns='http://www.w3.org/2000/svg' width='1100' height='720' viewBox='0 0 1100 720'>
  <defs>
    <marker id='arrow' viewBox='0 0 10 10' refX='8' refY='5' markerWidth='6' markerHeight='6' orient='auto-start-reverse'>
      <path d='M 0 0 L 10 5 L 0 10 z' fill='#3c4043'/>
    </marker>
  </defs>
  <style>
    text { font-family: "DejaVu Sans", Arial, sans-serif; fill: #202124; font-size: 14px; }
    .label { font-size: 13px; }
    .subtitle { font-size: 12px; fill: #5f6368; }
    .arrow { stroke: #3c4043; stroke-width: 2; fill: none; marker-end: url(#arrow); }
    .box { stroke: #1b1f23; stroke-width: 2; rx: 12; ry: 12; }
  </style>
"""


def _render_box(box: Box) -> str:
    lines = [escape(line) for line in box.text.split("\n")]
    text_y = box.y + 26
    tspans = []
    for idx, line in enumerate(lines):
        dy = 0 if idx == 0 else 20
        tspans.append(f"    <tspan x='{box.x + box.width / 2}' dy='{dy}' text-anchor='middle'>{line}</tspan>")
    tspans_str = "\n".join(tspans)
    return (
        f"  <rect class='box' x='{box.x}' y='{box.y}' width='{box.width}' height='{box.height}' fill='{box.fill}' />\n"
        f"  <text x='{box.x + box.width / 2}' y='{text_y}' text-anchor='middle'>\n{tspans_str}\n  </text>\n"
    )


def _render_arrow(arrow: Arrow) -> str:
    if arrow.curved and arrow.curve_offset:
        cx, cy = arrow.curve_offset
        path = (
            f"  <path class='arrow' d='M {arrow.start[0]} {arrow.start[1]} Q {cx} {cy} {arrow.end[0]} {arrow.end[1]}' />\n"
        )
    else:
        path = (
            f"  <line class='arrow' x1='{arrow.start[0]}' y1='{arrow.start[1]}' x2='{arrow.end[0]}' y2='{arrow.end[1]}' />\n"
        )

    label = ""
    if arrow.text:
        mid_x = (arrow.start[0] + arrow.end[0]) / 2
        mid_y = (arrow.start[1] + arrow.end[1]) / 2 - 6
        label = f"  <text class='label' x='{mid_x}' y='{mid_y}' text-anchor='middle'>{escape(arrow.text)}</text>\n"
    return path + label


def _render_svg(boxes: Iterable[Box], arrows: Iterable[Arrow]) -> str:
    svg_parts = [SVG_HEADER]
    for box in boxes:
        svg_parts.append(_render_box(box))
    for arrow in arrows:
        svg_parts.append(_render_arrow(arrow))
    svg_parts.append("</svg>\n")
    return "".join(svg_parts)


def build_diagram(path: str) -> None:
    boxes = [
        Box(60, 60, 270, 150, "高层规划层\n（慢思考）\n\n任务图语义 / 阶段性目标\n策略模式提示：优先规避/效率", "#d7e3f4"),
        Box(360, 60, 360, 150, "高层引导 + 中层门控\n基于策略模式提示的加权/门控机制\n\n输入：模式提示 + 观测嵌入\n输出：策略权重/门控系数", "#e7f2d8"),
        Box(60, 260, 230, 180, "环境观测 + 短期记忆\n\n实时态势、历史轨迹、威胁信息\n特征编码：LSTM/Transformer", "#f6e8d7"),
        Box(340, 240, 180, 120, "模式提示向量\n\n示例：\n[防御=0.8,效率=0.2]", "#f9e3d7"),
        Box(540, 240, 180, 120, "门控/加权网络\n\nMLP / 门控注意力\nσ(W·x+b) → α_i", "#f1e0fb"),
        Box(340, 380, 420, 210, "轻量策略模型库\n\n· 区域覆盖搜索\n· 目标跟踪与重识别\n· 编队突防与威胁规避\n· 物资投送与补给\n· 巡航与边界警戒", "#dfe8f5"),
        Box(800, 300, 230, 170, "策略执行 / 动作输出\n轨迹生成、任务调度、集群协同\n\n示例：威胁规避轨迹 +\n备用补给航线", "#f2d7ee"),
        Box(340, 610, 420, 90, "长期知识库 / 策略偏好\n任务成功率、资源利用率、模式偏好迭代", "#f7f3d7"),
    ]

    arrows = [
        Arrow((330, 135), (360, 135), "策略模式提示"),
        Arrow((290, 350), (340, 350), "观测编码"),
        Arrow((520, 300), (520, 360), "融合"),
        Arrow((520, 360), (520, 380), "α_i 权重/门控"),
        Arrow((760, 420), (800, 420), "加权输出"),
        Arrow((800, 420), (700, 620), "执行反馈", curved=True, curve_offset=(860, 600)),
        Arrow((520, 610), (520, 540), "长期偏好"),
        Arrow((450, 610), (450, 560), "离线预训练"),
        Arrow((590, 610), (590, 560), "在线微调"),
    ]

    example_note = (
        "案例：高层提示‘优先规避’，门控网络对威胁规避策略赋予高权重，"
        "对效率优先的补给/巡航策略降低权重；若任务偏好调整，则权重随之更新。"
    )
    footer_note = "门控可采用σ/Softmax归一化；注意力可用于多策略加权求和。"
    annotations = (
        f"  <text class='subtitle' x='{750}' y='{120}' text-anchor='middle'>{escape(example_note)}</text>\n"
        f"  <text class='subtitle' x='{750}' y='{140}' text-anchor='middle'>{escape(footer_note)}</text>\n"
    )

    svg_content = _render_svg(boxes, arrows).replace("</svg>\n", annotations + "</svg>\n")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as fp:
        fp.write(svg_content)


if __name__ == "__main__":
    output_path = os.path.join("docs", "strategy_decision_framework.svg")
    build_diagram(output_path)
    print(f"Saved diagram to {output_path}")
